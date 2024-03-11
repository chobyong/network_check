# purpose of this one
- check network connectivity and restart LTE modem, if it does not fix, will reload Linux node,
- LTE modem once in a while gets stuck

1. create file in /etc/systemd/system
```
[Unit]
Description=Check Network Connection

[Service]
ExecStart=/usr/local/bin/check_network.sh

[Install]
WantedBy=multi-user.target
```
2. then activate as a service `systemctl start check_network`
