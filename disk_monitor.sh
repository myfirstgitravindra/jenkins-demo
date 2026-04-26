#!/bin/bash

THRESHOLD=80

USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk usage is $USAGE%"

if [ $USAGE -ge $THRESHOLD ]
then
    echo "🚨 ALERT: Disk usage is HIGH ($USAGE%)"
else
    echo "✅ Disk usage is NORMAL ($USAGE%)"
fi
