FROM alpine:3.19
RUN apk add --no-cache curl ca-certificates
RUN SINGBOX_VERSION="1.11.0" && \
    curl -L -o /tmp/sing-box.tar.gz "https://github.com/SagerNet/sing-box/releases/download/v${SINGBOX_VERSION}/sing-box-${SINGBOX_VERSION}-linux-amd64.tar.gz" && \
    tar -xzf /tmp/sing-box.tar.gz -C /tmp && \
    mv /tmp/sing-box-${SINGBOX_VERSION}-linux-amd64/sing-box /usr/local/bin/sing-box && \
    chmod +x /usr/local/bin/sing-box && \
    rm -rf /tmp/sing-box*
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
