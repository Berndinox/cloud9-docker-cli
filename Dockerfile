FROM alpine:3.5

# ------------------------------------------------------------------------------
# Install: Base, Node, Docker Client
RUN apk update && apk add --no-cache g++ make python jq tmux nodejs bash ca-certificates curl git zip unzip && update-ca-certificates && apk add openssl \
 && curl -sl https://download.docker.com/linux/static/stable/x86_64/docker-17.06.2-ce.tgz --output docker-17.06.2-ce.tgz \
 && tar xzvf docker-17.06.2-ce.tgz && rm docker-17.06.2-ce.tgz && cp docker/* /usr/bin/

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git /cloud9 \
  && curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash \
  && /cloud9/scripts/install-sdk.sh \
  && apk del g++ make \
  && rm -rf /var/cache/apk/* /opt/cloud9/.git /tmp/* \
  && npm cache clean

WORKDIR /cloud9

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 8000
EXPOSE 3000

ENV USERNAME username
ENV PASSWORD password

# ------------------------------------------------------------------------------
# Start cloud9
ENTRYPOINT ["sh", "-c", "/usr/bin/node /cloud9/server.js -l 0.0.0.0 -p 8000 -w /workspace -a $USERNAME:$PASSWORD"]
