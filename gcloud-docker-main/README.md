# Gcloud Docker Container
Initial code for using Google's gcloud APIs from a docker container, instructions to use below.


## Gcloud
Adapted from documentation: https://cloud.google.com/sdk/docs/downloads-docker

1. Clone this repo

2. Pull Docker Image From Google

```bash
docker pull gcr.io/google.com/cloudsdktool/google-cloud-cli:stable
```


3. Auth Google

```bash
cd gcloud
docker run -ti --name gcloud-config gcr.io/google.com/cloudsdktool/google-cloud-cli:stable gcloud auth login
```

4. Build docker container

```bash
docker compose build gcloud
```

5. Run docker container

```bash
docker compose run gcloud /bin/bash
```

Now should have a terminal that can run gcloud commands from docker.
