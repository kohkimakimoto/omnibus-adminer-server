#!/usr/bin/env bash
[ -z "$BUILDSH" ] && exec buildsh "$0" "$@"

sudo git config --global user.email "kohki.makimoto@gmail.com"
sudo git config --global user.name "Kohki Makimoto"

sudo yum install -y rpm-build

sudo bundle install --system --binstubs
sudo bin/omnibus build adminer-server
