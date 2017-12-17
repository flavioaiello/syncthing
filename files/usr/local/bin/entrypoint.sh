#!/bin/sh

echo "*** Fix permissions when mounting external volumes running on technical user ***"
chown -R syncthing:syncthing /home/syncthing

if [[ ! -f ~/.config/syncthing/config.xml ]]; then
    echo "Config not found, generating"
    syncthing -generate="~/.config/syncthing/"
    sed -i -e "s#<globalAnnounceEnabled>true#<globalAnnounceEnabled>false#g" -e "s#<relaysEnabled>true#<relaysEnabled>false#g" ~/.config/syncthing/config.xml
fi

echo "*** Startup $0 suceeded now starting $@ ***"
exec su-exec syncthing $(eval echo "$@")
