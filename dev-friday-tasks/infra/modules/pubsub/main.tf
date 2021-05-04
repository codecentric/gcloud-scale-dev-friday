#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A GOOGLE CLOUD PUBSUB TOPIC
# https://cloud.google.com/pubsub/docs
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "google_pubsub_topic" "dataflow-target" {
  name = "simulator_client_request"
}

resource "google_pubsub_topic" "functions-target" {
  name = "request_buffer"
}