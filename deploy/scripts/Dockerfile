FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y docker.io

RUN jenkins-plugin-cli --plugins blueocean docker-workflow matrix-auth git workflow-aggregator credentials-binding configuration-as-code

USER jenkins