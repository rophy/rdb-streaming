FROM docker.io/fluentd:v1.16.2-debian-1.1

USER root

RUN apt-get update && apt-get install -y build-essential libpq-dev

RUN fluent-gem install fluent-plugin-sql --no-document \
    && fluent-gem install pg --no-document

