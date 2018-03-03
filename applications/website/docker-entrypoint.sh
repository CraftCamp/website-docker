#!/bin/bash
cd /
mkdir -p /srv/apps
if [ $DEPLOY_SOURCES == true ]; then
    rm -rf /srv/apps/official-website
    tar xf /srv/archives/official_website.tar.gz -C /srv/apps/
fi

if [ ! -d /srv/apps/asylamba-game/vendor ]; then
    composer install -d /srv/apps/official-website
fi

exec "$@"
