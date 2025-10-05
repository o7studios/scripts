FROM --platform=$BUILDPLATFORM debian AS paper

LABEL org.opencontainers.image.title="o7studios scripts" \
      org.opencontainers.image.description="A collection of scripts for managing your Dockerfile environments" \
      org.opencontainers.image.url="https://www.o7.studio/" \
      org.opencontainers.image.source="https://github.com/o7studios/scripts" \
      org.opencontainers.image.licenses="GPL-3.0-or-later" \
      org.opencontainers.image.vendor="o7studios" \
      org.opencontainers.image.authors="julian.siebert@o7.studio"

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl jq ca-certificates dos2unix
RUN rm -rf /var/lib/apt/lists/*

# Directory for scripts
ENV SCRIPT_DIR=/usr/local/bin
RUN mkdir -p $SCRIPT_DIR

# Copy all scripts into image
COPY download/* $SCRIPT_DIR/
COPY paper/* $SCRIPT_DIR/

RUN dos2unix $SCRIPT_DIR/*

# Make all scripts executable
RUN chmod +x $SCRIPT_DIR/*

# Ensure PATH contains the scripts
ENV PATH=$SCRIPT_DIR:$PATH

CMD ["sh"]
