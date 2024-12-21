#!/bin/bash

# Required environment variables
REQUIRED_VARS=(
  "DEBEZIUM_SINK_HTTP_URL"
  "PLANETSCALE_DB_USERNAME_READ_ONLY"
  "PLANETSCALE_DB_PASSWORD_READ_ONLY"
)

# Check required environment variables
for VAR in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!VAR}" ]; then
    echo "Error: Environment variable '$VAR' is not set or is empty."
    exit 1
  fi
done

# Define library path
LIB_PATH=$(find lib -name "*.jar" | tr '\n' ':')

# Path separator for different operating systems
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  PATH_SEP=";"
else
  PATH_SEP=":"
fi

# Determine Java binary
if [ -z "$JAVA_HOME" ]; then
  JAVA_BINARY="java"
else
  JAVA_BINARY="$JAVA_HOME/bin/java"
fi

# Find Debezium runner JAR
RUNNER=$(find . -maxdepth 1 -name "debezium-server-*runner.jar" | head -n 1)
if [ -z "$RUNNER" ]; then
  echo "Error: No debezium-server-*runner.jar found in the current directory."
  exit 1
fi

# Debug: print classpath and runner
echo "Classpath: $LIB_PATH"
echo "Runner JAR: $RUNNER"

# Enable optional scripting library
ENABLE_DEBEZIUM_SCRIPTING=${ENABLE_DEBEZIUM_SCRIPTING:-false}
if [[ "$ENABLE_DEBEZIUM_SCRIPTING" == "true" ]]; then
  LIB_PATH=$LIB_PATH$PATH_SEP"lib_opt/*"
fi

# JMX configuration
source ./jmx/enable_jmx.sh

# Debug: Check Java version
echo "Using Java binary: $JAVA_BINARY"
$JAVA_BINARY -version

# Execute Debezium Server
exec "$JAVA_BINARY" $DEBEZIUM_OPTS $JAVA_OPTS -cp \
    "$RUNNER"$PATH_SEP"conf"$PATH_SEP"$LIB_PATH" io.debezium.server.Main
