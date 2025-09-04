#!/bin/sh
set -e

# ensure gems are up to date
bundle check || bundle install


# Precompile assets (if not already done in Dockerfile)
echo "Precompiling assets..."
bundle exec rake assets:precompile

# Start Rails server
echo "Starting Rails in production mode..."
exec rails server -e production -b 0.0.0.0
