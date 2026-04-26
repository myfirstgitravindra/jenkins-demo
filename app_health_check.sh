#!/bin/bash

APP_NAME="myapp"

echo "Checking application status..."

if sudo docker ps | grep -q $APP_NAME
then
    echo "✅ Application is RUNNING"
else
    echo "❌ Application is NOT RUNNING"
    echo "Restarting application..."
    sudo docker start $APP_NAME
fi
