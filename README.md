
# MediaWiki Deployment

This project contains the necessary files to deploy MediaWiki on a Kubernetes cluster using custom Dockerfiles for the application and database. The project includes a Terraform files, Dockerfile, Kubernetes configuration files, and a README file.


## Prerequisites

1. Creating Kubernetes cluster by the help of terraform.
2. `kubectl` configured to interact with the cluster

## Deployment

1. Build the Docker image:

```bash
  docker build -t mediawiki:latest .
```

2. Push the Docker image to a container registry accessible by your Kubernetes cluster.

3. Create the required Kubernetes resources:

```bash
kubectl apply -f pv.yml
kubectl apply -f pvc.yml
kubectl apply -f storageclass.yml
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```


## Configuration
The following configuration files are included in this project:

1. Dockerfile: The Dockerfile used to build the MediaWiki Docker image.
2. mediawiki-pv.yaml: The PersistentVolume configuration for storing MediaWiki data.
3. mediawiki-pvc.yaml: The PersistentVolumeClaim configuration for requesting storage for MediaWiki.
4. mediawiki-storageclass.yaml: The StorageClass configuration for using local storage.
5. mediawiki-deployment.yaml: The Deployment configuration for running the MediaWiki application.
6. mediawiki-service.yaml: The Service configuration for exposing the MediaWiki application.
## Updating MediaWiki

To update MediaWiki, follow these steps:

1. Update the MediaWiki version in the Dockerfile.

2. Rebuild the Docker image:

```bash
docker build -t mediawiki:latest .

```

3. Push the updated Docker image to the container registry.

4. Restart the MediaWiki Deployment:

```bash

kubectl rollout restart deployment mediawiki

```
