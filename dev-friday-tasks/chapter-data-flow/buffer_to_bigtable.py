import apache_beam as beam
import json
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.gcp.bigtableio import WriteToBigTable

import logging

# The Google Cloud PubSub topic that we are reading from for this example.
PROJECT_ID = "<your project id>"
readFromTopic = f"projects/{PROJECT_ID}/topics/request_buffer"

class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_argument(
            '--bigtable-project',
            help='The Bigtable project ID, this can be different than your '
                 'Dataflow project')
        parser.add_argument(
            '--bigtable-instance',
            help='The Bigtable instance ID')
        parser.add_argument(
            '--bigtable-table',
            help='The Bigtable table ID in the instance.')


class CreateRowFn(beam.DoFn):
    def process(self, record):
        # Import must be inside here
        from google.cloud.bigtable import row
        record_dict = json.loads(record)
        logging.info(record_dict)
        logging.info(type(record_dict))

        keycombined = f"{record_dict.get('domain')}#{record_dict.get('user')}"
        direct_row = row.DirectRow(row_key=keycombined)
        import datetime as dt
        direct_row.set_cell(
            "cf1", #column_family muss zuvor angelegt sein
            "services", #column_name
            json.dumps(record_dict['services']), # cell_value
            timestamp =dt.datetime.utcnow())
        direct_row.set_cell(
            "cf1", #column_family muss zuvor angelegt sein
            "message_timestamp", #column_name
            json.dumps(record_dict['message_timestamp']), # cell_value
            timestamp =dt.datetime.utcnow())
        return [direct_row]


def run(argv=None):
    """Build and run the pipeline."""
    options = MyOptions(
        flags=argv,
        runner='DataflowRunner',
        project=PROJECT_ID,
        job_name='buffer-to-bigtable',
        temp_location=f'gs://{PROJECT_ID}-scale/dataflow/tmp',
        region='europe-west1',
        autoscaling_algorithm='THROUGHPUT_BASED',
        streaming=True)

    with beam.Pipeline(options=options) as p:
        p | "read" >> beam.io.ReadFromPubSub(topic=readFromTopic) | beam.ParDo(CreateRowFn()) | WriteToBigTable(
            project_id=PROJECT_ID,
            instance_id="scale-bigtable",
            table_id="scale-traffic")

run()
