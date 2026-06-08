#!/bin/bash
# Accept two command-line arguments and assign them to variables
FIRST_NAME=$1
LAST_NAME=$2
# Create a new file named output.txt (or overwrite if it exists)
# Write the current date in DD-MM-YYYY format to output.txt
date +"%d-%m-%Y" > output.txt
# Write the full name to output.txt (appending after the date)
echo "$FIRST_NAME $LAST_NAME" >> output.txt
# Make a backup copy of output.txt named backup.txt
cp output.txt backup.txt
# Print the content of output.txt to standard output
cat output.txt