FROM ruby:2.2.3-slim
MAINTAINER Sento <info@sento.io>

RUN apt-get update && \
  apt-get install -qq -y build-essential \
                        nodejs \
                        git \
                        libpq-dev \
                        libfontconfig \
                        --fix-missing --no-install-recommends

ENV PHANTOMJS_VERSION 2.1.1

# ~~~~ Phantomjs ~~~~
RUN cd /tmp && \
    curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
    tar xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
    mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm -rf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64

ENV INSTALL_PATH /application/lib/sento/kanban/
RUN mkdir -p $INSTALL_PATH
WORKDIR /application/

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile* ./
COPY *.gemspec ./
COPY lib/sento/kanban/version.rb lib/sento/kanban/
RUN bundle install -j $(nproc)

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .
