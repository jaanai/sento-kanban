FROM ruby:2.2.3-slim
MAINTAINER Sento <info@sento.io>

RUN apt-get update && \
  apt-get install -qq -y build-essential \
                        nodejs \
                        git \
                        --fix-missing --no-install-recommends

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
