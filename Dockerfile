FROM alpine:3.6

ENV SYNCTHING_VERSION=0.14.19
ENV STNOUPGRADE=TRUE

# Add local files to image
COPY files /
    
RUN set -ex;\
    apk update;\
    apk upgrade;\
    apk add --no-cache su-exec tini curl;\
    rm -rf /var/cache/apk/*

# Syncthing
RUN set -ex;\
    echo "Installing Syncthing ${SYNCTHING_VERSION} ...";\
    mkdir /opt;\
    curl -sSL --retry 1 https://github.com/syncthing/syncthing/releases/download/v${SYNCTHING_VERSION}/syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz | tar -C /opt -xvz;\
    ln -s /opt/syncthing-linux-amd64-v${SYNCTHING_VERSION}/syncthing /usr/local/bin;\
    chmod -R +x /usr/local/bin

EXPOSE 8384 22000 21027/udp

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["/usr/local/bin/syncthing", "-no-browser", "-no-restart", "-gui-address=0.0.0.0:8384", "-verbose"]
