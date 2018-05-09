FROM kong:0.13.1-alpine

RUN apk update \
    && apk add unzip curl \
    && rm -rf /var/cache/apk/*

ENV CONSUL_VERSION=1.0.6
RUN curl -o consul.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
RUN unzip consul.zip
RUN chmod +x consul
RUN mv consul /usr/bin
RUN mkdir /consul

# get ContainerPilot release
ENV CONTAINERPILOT_VERSION 3.0.0
RUN export CP_SHA1=6da4a4ab3dd92d8fd009cdb81a4d4002a90c8b7c \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz

#This is the only custom code 
COPY kong/plugins/dataset-access /usr/local/share/lua/5.1/kong/plugins/dataset-access
COPY kong/plugins/ip-auth /usr/local/share/lua/5.1/kong/plugins/ip-auth

COPY docker/docker-entrypoint.sh /docker-entrypoint.sh

ENV CONTAINERPILOT=/etc/containerpilot.json

CMD /bin/containerpilot

EXPOSE 8000 8443 8001 7946
