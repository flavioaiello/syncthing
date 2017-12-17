#!/bin/sh

if [[ ! -f ~/.config/syncthing/config.xml ]]; then
    echo "Config not found, generating"
    syncthing -generate="~/.config/syncthing/"
    sed -i -e "s#<globalAnnounceEnabled>true#<globalAnnounceEnabled>false#g" -e "s#<relaysEnabled>true#<relaysEnabled>false#g" ~/.config/syncthing/config.xml
fi

echo "*** Startup $0 suceeded now starting service using eval to expand CMD variables ***"
exec $(eval echo "$@")
