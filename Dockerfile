# Use the official Debezium Server image as the base image
FROM quay.io/debezium/server:latest

# Set the working directory to the directory where Debezium expects its files
WORKDIR /debezium

# Copy your local folder content into the container's /debezium directory
COPY . .

# Ensure the run.sh script is executable
RUN chmod +x run.sh

# Expose the port that Debezium Server listens on
EXPOSE 8080

# Start Debezium Server
CMD ["./run.sh"]
