FROM --platform=$BUILDPLATFORM debian AS paper

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl jq ca-certificates
RUN rm -rf /var/lib/apt/lists/*

# Directory for scripts
ENV SCRIPT_DIR=/usr/local/bin
RUN mkdir -p $SCRIPT_DIR

# Copy all scripts into image
COPY download/* $SCRIPT_DIR/
COPY paper/* $SCRIPT_DIR/

# Make all scripts executable
RUN chmod +x $SCRIPT_DIR/*

# Ensure PATH contains the scripts
ENV PATH=$SCRIPT_DIR:$PATH

CMD ["sh"]
