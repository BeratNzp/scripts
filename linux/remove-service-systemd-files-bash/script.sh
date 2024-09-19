#!/bin/bash
TEMPSERVICENAME=$1
sudo systemctl stop $TEMPSERVICENAME
sudo systemctl disable $TEMPSERVICENAME
sudo rm /etc/systemd/system/$TEMPSERVICENAME
sudo rm /etc/systemd/system/$TEMPSERVICENAME
sudo rm /usr/lib/systemd/system/$TEMPSERVICENAME
sudo rm /usr/lib/systemd/system/$TEMPSERVICENAME
sudo systemctl daemon-reload
sudo systemctl reset-failed
