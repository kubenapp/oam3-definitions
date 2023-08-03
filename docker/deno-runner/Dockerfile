FROM denoland/deno:1.35.3

RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get install unzip -y
# Set the working directory inside the container
WORKDIR /app

# Copy the script to the container
COPY deno-napptive.sh /app/deno-napptive.sh

# Make the script executable
RUN chmod +x /app/deno-napptive.sh

# Set default command to run the script
ENTRYPOINT ["/app/deno-napptive.sh"]