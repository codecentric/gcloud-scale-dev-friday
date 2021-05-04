# Some README

## Install

- Download the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- Install [`terraform`](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Install [`terragrunt`](https://terragrunt.gruntwork.io/docs/getting-started/install/)


## Configure

Before doing everyting, authenticate your Google Cloud SDK:

- `export PROJECT=<<YOUR_PROJECT_ID>>`, makes things subsequently easier
- `gcloud config configurations create $PROJECT` to create your Google Cloud SDK config
- `gcloud config configurations activate $PROJECT` to activate your Google Cloud SDK config
- `gcloud auth login` to authenticate yourself to the SDK and
- `gcloud config set project $PROJECT` to set the project in your current
- `gcloud auth application-default login`, such that `terragrunt` can execute the commands on your behalf

## Build and destroy `infra`

1. Make sure your have the `PROJECT` environment variable set
2. Do a `terragrunt init`
3. Do `cd live/dev`
4. Run `terragrunt plan-all` to check if it works fine
5. Run `terragrunt apply-all` to apply all resources. You need to type in `yes` at some point.
6. When you are done experimenting, run `terragrunt destroy-all`
7. You can deploy each resource on its own by going into the folder in `live` and running `terragrunt apply` or `terragrunt destroy` in there.

## Resources

- https://github.com/gruntwork-io/terraform-google-ci
- https://github.com/gruntwork-io/terraform-google-gke
- [`terragrunt` "live"](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example)
- [`terragrunt` "modules"](https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example)
- [Google Project Factory with sensible defaults](https://github.com/terraform-google-modules/terraform-google-project-factory)
