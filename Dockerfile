# Use the official Debezium Server image as the base image
FROM quay.io/debezium/server:latest

# Set the working directory inside the container
WORKDIR /debezium

# Copy your custom configuration file into the container
COPY conf/application.properties conf/application.properties

COPY lib/debezium-connector-planetscale-2.4.0.Final-jar-with-dependencies.jar lib/debezium-connector-planetscale-2.4.0.Final-jar-with-dependencies.jar

# Expose the port that Debezium Server listens on
EXPOSE 8080

# Start Debezium Server
CMD ["./run.sh"]
