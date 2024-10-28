# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Install AWS SAM CLI
RUN curl -sSL https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-arm64.zip -o sam-cli.zip && \
    unzip sam-cli.zip -d sam-installation && \
    ./sam-installation/install && \
    rm -rf sam-cli.zip sam-installation

# Verify installations
RUN aws --version && \
    sam --version && \
    python --version

WORKDIR /lambda
