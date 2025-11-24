FROM alpine:latest

# install bash (no cache to keep image small)
RUN apk add --no-cache bash

# create a non-root group and user, set up home directory and fix ownership
RUN addgroup -S appgroup \
 && adduser -S -G appgroup -h /home/appuser -s /bin/bash appuser \
 && mkdir -p /home/appuser/app \
 && chown -R appuser:appgroup /home/appuser

WORKDIR /home/appuser/app

# copy files as the non-root user (requires Docker engine supporting --chown)
COPY --chown=appuser:appgroup dummy.txt .

# switch to non-root user for runtime
USER appuser

# default command for quick testing
CMD ["bash"]
