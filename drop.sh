#!/bin/bash
#
# drop.sh
#
# ------------------------------------------------------------------------
cd cn0
sudo vagrant destroy -f
cd ../cn1
sudo vagrant destroy -f
cd ../cn2
sudo vagrant destroy -f
cd  ../cn3
sudo vagrant destroy -f
