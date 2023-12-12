# python-gcloud-k8s-client

[![GitHub](https://img.shields.io/badge/GitHub-repository---)](https://github.com/toms74209200/python-gcloud-k8s-client)
[![Docker Hub](https://img.shields.io/badge/Docker%20Hub---?color=1D63ED)](https://hub.docker.com/r/motomotomato/python-gcloud-k8s-client)
[![version](https://img.shields.io/github/v/tag/toms74209200/python-gcloud-k8s-client)](https://github.com/toms74209200/python-gcloud-k8s-client/tags)
[![status](https://github.com/toms74209200/python-gcloud-k8s-client/actions/workflows/image_build.yml/badge.svg)](https://github.com/toms74209200/python-gcloud-k8s-client/actions/workflows/image_build.yml)

Google Kubernetes Engine Python client Docker image.

This image is based on the official Python image and contains the Google Cloud SDK and the Kubernetes client.

## Usage

```bash
$ docker pull motomotomato/python-gcloud-k8s-client
```

To run Python script, you can use CMD instruction in Dockerfile.

```dockerfile
FROM motomotomato/python-gcloud-k8s-client

ENV CLUSTER_NAME=cluster-name
ENV REGION=region
ENV PROJECT_ID=project-id

COPY main.py .
CMD ["main.py"]
```

By default, this image uses automatically authentication with the Google Cloud SDK. If you want to use a service account, you can override ENTRYPOINT instruction in Dockerfile by [entorypoint.sh](entrypoint.sh) script.

**`entrypoint.sh`**
```bash
#!/bin/bash

gcloud auth activate-service-account --key-file=service-account.json
gcloud container clusters get-credentials ${CLUSTER_NAME} --region ${REGION} --project ${PROJECT_ID}

python $@
```

By using docker-compose, you can use the service account file and environment variables.

**`docker-compose.yml`**
```yaml
services:
  python-gcloud-k8s-client:
    image: motomotomato/python-gcloud-k8s-client
    volumes:
      - ./service-account.json:/service-account.json
      - ./main.py:/main.py
      - ./entrypoint.sh:/entrypoint.sh
    environment:
      GOOGLE_APPLICATION_CREDENTIALS: /service-account.json
      CLUSTER_NAME: cluster-name
      REGION: region
      PROJECT_ID: project-id
    command: /main.py
```

## Installed packages

- [google-cloud-logging](https://pypi.org/project/google-cloud-logging/)

- [kubernetes](https://pypi.org/project/kubernetes/)

## Reference

- [gcloud container  |  Google Cloud CLI Documentation](https://cloud.google.com/sdk/gcloud/reference/container)  
https://cloud.google.com/sdk/gcloud/reference/container

- [kubernetes-client/python: Official Python client library for kubernetes](https://github.com/kubernetes-client/python)  
https://github.com/kubernetes-client/python

- [Install kubectl and configure cluster access  |  Google Kubernetes Engine (GKE)  |  Google Cloud](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl)  
https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl

## License

MIT License

## Author

[toms74209200](<https://github.com/toms74209200>)
