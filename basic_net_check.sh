#!/bin/bash

echo "===== Network Check Started ====="

echo "1. Checking internet connectivity..."
ping -c 3 google.com

echo ""
echo "2. Checking open ports..."
netstat -tulnp

echo ""
echo "===== Check Completed ====="
