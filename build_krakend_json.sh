#!/bin/sh

FC_ENABLE=1 \
FC_OUT=out.json \
FC_SETTINGS="settings/dev" \
FC_TEMPLATES="settings/endpoints" \
krakend check -d -c "krakend.json"