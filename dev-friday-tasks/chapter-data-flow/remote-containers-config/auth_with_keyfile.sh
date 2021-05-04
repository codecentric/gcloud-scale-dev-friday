#!/bin/bash
echo "Using keyfile path:"
echo $GOOGLE_APPLICATION_CREDENTIALS
if ! test -f "$GOOGLE_APPLICATION_CREDENTIALS"; then
    echo "Check the path to keyfile in dockerfile and rebuild the container"
    exit
fi
export CLIENT_EMAIL=$(jq -r ".client_email" $GOOGLE_APPLICATION_CREDENTIALS)
echo "read client email:"
echo $CLIENT_EMAIL
export PROJECT_ID=$(jq -r ".project_id" $GOOGLE_APPLICATION_CREDENTIALS)
echo "read project id:"
echo $PROJECT_ID
gcloud auth activate-service-account $CLIENT_EMAIL --key-file=$GOOGLE_APPLICATION_CREDENTIALS
gcloud config set project $PROJECT_ID