#!/bin/bash
# Adjust this file accordingly to the output of the tool

# Initialize first outside the loop to manage comma placement
first=1

# Start of JSON array
echo "["

while read -r line; do
    # Check if the line contains iperf3 data
    if echo "$line" | grep -q "iperf3"; then
        if [ $first -eq 1 ]; then
            first=0
        else
            echo ","  # Print a comma before each JSON object except the first
        fi
        # Extract relevant information using awk and output directly in JSON format
        ip_address=$(echo "$line" | awk '{print $3}')
        port=$(echo "$line" | awk '{print $4}')
        interval=$(echo "$line" | awk '{print $5}')
        transfer=$(echo "$line" | awk '{print $6}')
        
        # Print the extracted information in JSON format to stdout
        echo -n "{\"IP Address\": \"$ip_address\", \"Port\": \"$port\", \"Interval\": \"$interval\", \"Transfer\": \"$transfer\"}"
    fi
done

# End of JSON array
echo -e "\n]"
