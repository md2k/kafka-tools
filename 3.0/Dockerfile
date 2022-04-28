FROM bitnami/kafka:3.0

USER root

# Install some tools
RUN \
  apt-get update && apt-get install -y bzip2 gzip xz-utils dnsutils vim jq wget && \
  apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}

# NOTE: 13.1.0 has issues
ARG KT_VER=13.0.0
RUN \
  mkdir -p /tmp/kt && \
  wget -c "https://github.com/fgeller/kt/releases/download/v${KT_VER}/kt-v${KT_VER}-linux-amd64.txz" -P /tmp/kt/ && \
  cd /tmp/kt && tar xvf ./*.txz && \
  chmod +x ./kt && mv ./kt /usr/sbin/kt

# Add Home folder for user
RUN groupadd --gid 1000 docker && useradd --uid 1000 --gid docker --shell /bin/bash --create-home docker
# Run by default as `docker` user
USER docker
