#!/bin/bash

# Check if all required environment variables are set locally
if [[ -z "$PLANETSCALE_DB_USERNAME_READ_ONLY" || -z "$PLANETSCALE_DB_PASSWORD_READ_ONLY" || -z "$DEBEZIUM_SINK_HTTP_URL" ]]; then
  echo "Error: One or more required environment variables are not set locally."
  echo "Please set the following variables in your local environment:"
  echo "  PLANETSCALE_DB_USERNAME_READ_ONLY"
  echo "  PLANETSCALE_DB_PASSWORD_READ_ONLY"
  echo "  DEBEZIUM_SINK_HTTP_URL"
  exit 1
fi

# Set environment variables as Fly.io secrets using local values
flyctl secrets set \
  PLANETSCALE_DB_USERNAME_READ_ONLY="$PLANETSCALE_DB_USERNAME_READ_ONLY" \
  PLANETSCALE_DB_PASSWORD_READ_ONLY="$PLANETSCALE_DB_PASSWORD_READ_ONLY" \
  DEBEZIUM_SINK_HTTP_URL="$DEBEZIUM_SINK_HTTP_URL"

# Confirm that secrets have been set
echo "Environment variables have been securely set on Fly.io."
