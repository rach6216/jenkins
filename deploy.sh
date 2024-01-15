#!/bin/bash
version='latest'
docker build -t jenkins .
gcloud auth configure-docker me-west1-docker.pkg.dev
docker tag jenkins/jenkins:lts me-west1-docker.pkg.dev/devconnect-project/rachel-fabian-artifacts/jenkins
docker push me-west1-docker.pkg.dev/devconnect-project/rachel-fabian-artifacts/jenkins
# gcloud compute ssh rachel_fabian@rachel-fabian-jenkins --project devconnect-project --zone us-central1-a --command "gcloud auth configure-docker me-west1-docker.pkg.dev;  docker pull me-west1-docker.pkg.dev/devconnect-project/rachel-fabian-artifacts/jenkins; docker volume create  jenkins_home; docker run -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home --name jenkins -p 8000:8000 me-west1-docker.pkg.dev/devconnect-project/rachel-fabian-artifacts/jenkins:latest" 
gcloud compute ssh rachel_fabian@rachel-fabian-jenkins --project devconnect-project --zone us-central1-a --command "gcloud auth configure-docker me-west1-docker.pkg.dev; docker stop jenkins; docker rm jenkins; docker rmi jenkins ;docker pull me-west1-docker.pkg.dev/devconnect-project/rachel-fabian-artifacts/jenkins; docker volume create jenkins_home; docker run -p 8080:8080 -p 50000:50000 --restart=on-failure -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home --name jenkins  me-west1-docker.pkg.dev/devconnect-project/rachel-fabian-artifacts/jenkins:latest" 