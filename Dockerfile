# syntax = docker/dockerfile:1

# Base image for Ruby
ARG RUBY_VERSION=3.0.6
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Node image for building frontend assets
FROM node:21-alpine3.19 as node

# Final image for production build
FROM base as production

# Set working directory
WORKDIR /rails

# Environment variables for production
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# Install essential packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config libssl-dev zlib1g-dev curl && \
    rm -rf /var/lib/apt/lists/*

# Install Ruby and Bundler
RUN gem install bundler:2.5.5

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}/ruby/*/cache" "${BUNDLE_PATH}/ruby/*/bundler/gems/*/.git"

# Copy application code
COPY . .

# Set up Node.js and Yarn
ENV NODE_VERSION=16.13.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}

ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Install Node.js and Yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/bin/npm /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN npm install -g yarn

# Install Node dependencies
COPY yarn.lock package.json ./
RUN yarn install
RUN npx update-browserslist-db@latest

# Remove the server.pid if it exists to avoid potential issues
RUN rm -f tmp/pids/server.pid

# Ensure logs are not accessible by others
RUN chmod 640 log/*

# Expose the port that Puma is bound to
EXPOSE 3000

# Specify the command to run the application server
CMD ["./bin/dev"]
