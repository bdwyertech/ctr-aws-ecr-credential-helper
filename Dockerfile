FROM alpine:latest AS downloader
RUN apk add --no-cache curl
RUN mkdir -p /opt/bin
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then ARCH="arm64"; else ARCH="amd64"; fi && \
    curl -L https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.11.0/linux-${ARCH}/docker-credential-ecr-login -o /opt/bin/docker-credential-ecr-login
RUN chmod +x /opt/bin/docker-credential-ecr-login

FROM scratch
COPY --from=downloader /opt/bin/docker-credential-ecr-login /opt/bin/docker-credential-ecr-login