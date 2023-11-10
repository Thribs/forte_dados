# Dockerfile for Flutter

# Specify a base image
FROM debian:bullseye

# Maintainer
LABEL maintainer="Thiago <thiago@gmail.com>"

# Set environment variables
ENV FLUTTER_VERSION=3.13.9
ENV FLUTTER_HOME=/opt/flutter

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    git \
    curl \
    file \
    zip \
    unzip \
    xz-utils \
    cmake \
    ninja-build \
    libgtk-3-dev \
    clang \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone -b ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Add flutter to PATH
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

# Verify flutter installation
RUN flutter doctor

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Run flutter
RUN flutter run

# Expose port
EXPOSE 8080

# Run the command when the container launches
CMD [ "flutter", "run"  ]
