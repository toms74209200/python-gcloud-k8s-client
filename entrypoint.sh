#!/bin/bash

set -e

gcloud auth login
gcloud container clusters get-credentials ${CLUSTER_NAME} --region ${REGION} --project ${PROJECT_ID}