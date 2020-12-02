FROM alpine:latest AS rclone
ARG RCLONE_VERSION=v1.53.3
RUN apk add --no-cache curl unzip \
	&& curl -LO https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip \
	&& unzip rclone-${RCLONE_VERSION}-linux-amd64.zip \
	&& mv rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/bin/rclone \
	&& chmod 755 /usr/bin/rclone \
	&& chown root:root /usr/bin/rclone

FROM alpine:latest

RUN apk add --no-cache borgbackup
COPY --from=rclone /usr/bin/rclone /usr/bin/rclone
