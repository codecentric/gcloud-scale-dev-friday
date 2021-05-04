# gcloud and project setup via cli (OPTIONAL)

# Prerequisites:

* Python must be installed. (>2.7 | >3.5)

* For installing the sdk follow the instructions in the google help https://cloud.google.com/sdk/docs/quickstart


# Initialize gcloud and Dev Friday project
```
gcloud init
```

Log in to your google Account and follow the command line instructions to create a new project, or connect to a project you have created before.

If you are logged in to a different account you want to use for the dev friday: 
```
gcloud auth revoke [ACCOUNTS …] [--all]  
gcloud auth login
```

In some cases, `auth login` doesnt work properly. In that cases use:
```
gcloud auth login --no-launch-browser
```

Check your active configuration:
```
gcloud config list
```


To connect an existing project: 
```
gcloud config set project [PROJECT_ID]
```

To create a new project: 

```
gcloud projects create [PROJECT_ID] [--name=YOUR_NAME] ... 
```

  After creating the project you need to set the billing account


  TODO IMAGES