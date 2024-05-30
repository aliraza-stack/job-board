# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.0.6
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

FROM node:21-alpine3.19 as node

# Throw-away build stage to reduce size of final image
FROM base as build

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config libssl-dev zlib1g-dev curl && \
    rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION=16.13.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION} && \
    . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION} && \
    . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}

ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Copy Node.js and Yarn from the Node image
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/bin/npm /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN npm install -g yarn

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.5
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}/ruby/*/cache" "${BUNDLE_PATH}/ruby/*/bundler/gems/*/.git"

# Copy application code
COPY . .

# Node dependencies
COPY yarn.lock package.json ./
RUN yarn install

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets for production
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Set working directory
WORKDIR /rails

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl postgresql-client build-essential git libpq-dev libvips pkg-config libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Copy the entrypoint script
COPY docker-entrypoint /rails/bin/docker-entrypoint
RUN chmod +x /rails/bin/docker-entrypoint

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp node_modules /rails /usr/local/bundle
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose the application server port
EXPOSE 3000

# Start the server by default
CMD ["./bin/dev"]
