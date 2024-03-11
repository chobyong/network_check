#!/bin/bash

# Initialize failure counter
failure_count=0

while true; do
    # Ping 8.8.8.8 via wwan0 interface
    if ping -I wwan0 -c 1 8.8.8.8 &> /dev/null
    then
        # If ping is successful, reset failure counter
        failure_count=0
    else
        # If ping fails, increment failure counter
        ((failure_count++))
    fi

    # If ping fails for more than an hour (6 failures), restart network service
    if [ $failure_count -eq 6 ]; then
        /etc/init.d/networking restart
    fi

    # If ping fails after network service restart, reboot the system
    if [ $failure_count -gt 6 ]; then
        reboot
    fi

    # Wait for 10 minutes before next ping
    sleep 600

done
