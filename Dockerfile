# Container image that runs your code
FROM ghcr.io/deislabs/ratify:v0.1.1-alpha.1

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY config.json /config.json
RUN apk add jq

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]