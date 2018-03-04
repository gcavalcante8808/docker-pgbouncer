FROM alpine:3.7
ADD docker-entrypoint.sh /
RUN apk add --no-cache pgbouncer bash && \
    chmod +x /docker-entrypoint.sh && \
    chown -R pgbouncer /etc/pgbouncer
USER pgbouncer
EXPOSE 5432
ENTRYPOINT ["/docker-entrypoint.sh"]
