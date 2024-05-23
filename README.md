MediaWiki Kubernetes Deployment
This project contains the necessary files to deploy MediaWiki on a Kubernetes cluster using custom Dockerfiles for the application and database. The project includes a Dockerfile, Kubernetes configuration files, and a README file.

Prerequisites
A running Kubernetes cluster
kubectl configured to interact with the cluster
Deployment Steps
Build the Docker image:

bash
Edit
Run
Full Screen
Copy code
docker build -t mediawiki:latest .
Push the Docker image to a container registry accessible by your Kubernetes cluster.

Create the required Kubernetes resources:

bash
Edit
Run
Full Screen
Copy code
kubectl apply -f mediawiki-pv.yaml
kubectl apply -f mediawiki-pvc.yaml
kubectl apply -f mediawiki-storageclass.yaml
kubectl apply -f mediawiki-deployment.yaml
kubectl apply -f mediawiki-service.yaml
Access the MediaWiki application using the LoadBalancer IP and port 80 or 443.

Configuration
The following configuration files are included in this project:

Dockerfile: The Dockerfile used to build the MediaWiki Docker image.
mediawiki-pv.yaml: The PersistentVolume configuration for storing MediaWiki data.
mediawiki-pvc.yaml: The PersistentVolumeClaim configuration for requesting storage for MediaWiki.
mediawiki-storageclass.yaml: The StorageClass configuration for using local storage.
mediawiki-deployment.yaml: The Deployment configuration for running the MediaWiki application.
mediawiki-service.yaml: The Service configuration for exposing the MediaWiki application.
Updating MediaWiki
To update MediaWiki, follow these steps:

Update the MediaWiki version in the Dockerfile.

Rebuild the Docker image:

bash
Edit
Run
Full Screen
Copy code
docker build -t mediawiki:latest .
Push the updated Docker image to the container registry.

Restart the MediaWiki Deployment:

bash
Edit
Run
Full Screen
Copy code
kubectl rollout restart deployment mediawiki
