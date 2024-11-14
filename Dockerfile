FROM alpine:3.18.4
RUN apk --no-cache add squid bind-tools 

ENV SQUID_LOGS_DIR="/var/log/squid"

RUN mkdir -p $SQUID_LOGS_DIR && \
    chown -R squid:squid $SQUID_LOGS_DIR && \
    chmod -R 755 $SQUID_LOGS_DIR

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./squid.conf.dist /etc/squid/squid.conf

EXPOSE 3128

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# "N" - non-daemon, "Y" - syntax check, "d 1" - debug level 1
CMD sh -c '/usr/sbin/squid -NYd 1'