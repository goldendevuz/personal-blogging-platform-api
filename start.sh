#!/bin/bash
cd /workspaces/personal-blogging-platform-api
export DJANGO_SETTINGS_MODULE=configd.settings
gunicorn configd.wsgi:application --bind 0.0.0.0:8000
