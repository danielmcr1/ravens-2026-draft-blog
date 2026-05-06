# Dockerfile for building the Ravens 2026 Draft Blog Jekyll site
# Used in CI to demonstrate containerised builds — the resulting
# image is a portable, reproducible build environment.

FROM ruby:3.2-alpine

LABEL org.opencontainers.image.title="Ravens 2026 Draft Blog Builder"
LABEL org.opencontainers.image.description="Containerised Jekyll build environment for the BPP Level 5 DevOps coursework."
LABEL org.opencontainers.image.source="https://github.com/danielmcr1/ravens-2026-draft-blog"
LABEL org.opencontainers.image.licenses="MIT"

# Install build dependencies for native gems
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    && rm -rf /var/cache/apk/*

WORKDIR /site

# Install bundler and Jekyll first to leverage Docker layer caching
COPY Gemfile ./
RUN gem install bundler -v '~> 2.5' \
    && bundle config set --local deployment 'false' \
    && bundle install --jobs 4 --retry 3

# Copy the rest of the site
COPY . .

# Build the static site into _site/
RUN bundle exec jekyll build --trace

# Default command — useful for local inspection (`docker run --rm -p 4000:4000 ravens-blog`)
EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--no-watch"]
