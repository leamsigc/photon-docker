FROM openjdk:11

# Install pbzip2 for parallel extraction
RUN apt-get update \
    && apt-get -y install \
    pbzip2 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Use the environment variable $PHOTON_VERSION to specify the version of the Photon or set default to 5.0.0
ARG PHOTON_VERSION
ENV PHOTON_VERSION ${PHOTON_VERSION:-0.5.0}
# Show the version to dowmload in the container logs
RUN echo $PHOTON_VERSION
RUN mkdir -p /usr/photon
# Download the Photon jar file
WORKDIR /usr/photon

RUN mkdir -p /usr/dowmload && wget -O /usr/dowmload/photon.jar https://github.com/komoot/photon/releases/download/$PHOTON_VERSION/photon-$PHOTON_VERSION.jar && ls
COPY ./entrypoint.sh /usr/bin/entrypoint.sh

EXPOSE 2322
ENTRYPOINT /usr/bin/entrypoint.sh
