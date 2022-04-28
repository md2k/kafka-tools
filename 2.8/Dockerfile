FROM bitnami/kafka:2.8

USER root

# Install some tools
RUN \
  apt-get update && apt-get install -y bzip2 gzip xz-utils dnsutils vim jq wget && \
  apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}

# Add Home folder for user
RUN groupadd --gid 1000 docker && useradd --uid 1000 --gid docker --shell /bin/bash --create-home docker
# Run by default as `docker` user
USER docker
