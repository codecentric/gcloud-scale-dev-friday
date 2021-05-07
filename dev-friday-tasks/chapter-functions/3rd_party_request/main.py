from google.cloud import bigtable
from google.cloud.bigtable.row_set import RowSet
from google.cloud.bigtable import row_filters

client = bigtable.Client()


def bigtable_read_data(request):
    instance = client.instance('scale-bigtable')
    table = instance.table('scale-traffic')
    column_family_id = 'cf1'

    key = request.args.get('user').encode()
    print(key)
    row = table.read_row(key)
    column = 'services'
    cell = row.cell_value(column_family_id, column)
    return cell
