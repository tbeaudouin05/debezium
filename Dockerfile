# Use an appropriate base image, such as OpenJDK for running Java applications
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /debezium

# Copy the Debezium Server distribution files into the container
COPY . .

# Make the run.sh script executable
RUN chmod +x run.sh

# Expose the port that Debezium Server listens on
EXPOSE 8080

# Start Debezium Server
CMD ["./run.sh"]

