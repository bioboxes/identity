FROM ubuntu:14.04
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

# Add the bioboxes debian repository
RUN echo "deb http://debian.bioboxes.org stable main" >> /etc/apt/sources.list

# Allow anauthenticated installes - not good
# Need to do this until debian.bioboxes.org has an SSL cert
RUN apt-get update -y && \
    apt-get install -y --allow-unauthenticated validate-biobox-file wget

ADD schema.yaml /

ENV CONVERT https://github.com/bronze1man/yaml2json/raw/master/builds/linux_386/yaml2json
# download yaml2json and make it executable
RUN cd /usr/local/bin && wget --quiet ${CONVERT} && chmod 700 yaml2json

ENV JQ http://stedolan.github.io/jq/download/linux64/jq
# download jq and make it executable
RUN cd /usr/local/bin && wget --quiet ${JQ} && chmod 700 jq

ADD process /usr/local/bin/
ENTRYPOINT ["process"]
