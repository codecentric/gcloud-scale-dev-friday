FROM apache/beam_python3.7_sdk

# Use for authentication
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!KEY-FILE-NAME-HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#If you like to handle authentication by yourself just ignore this. For more information 
#read the next paragraph Create a keyfile with a service-account
ENV GOOGLE_APPLICATION_CREDENTIALS=.devcontainer/<name-of-keyfile>.json
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!KEY-FILE-NAME-HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the gcloud package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh --quiet

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends jq

# Use ${user} instead of root
ARG user=vscode
RUN useradd -ms /bin/bash ${user}
USER ${user}