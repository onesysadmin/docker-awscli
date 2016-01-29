FROM alpine:latest

ENTRYPOINT ["aws"]

# gvm requires curl and unzip
RUN apk --no-cache add python py-pip

# install newest version of awscli available
RUN pip install awscli
