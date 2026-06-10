#!/bin/bash
SIGNAL_TO_STOP_FILE="stoploop" # Creates a variable named SIGNAL_TO_STOP_FILE and stores the filename stoploop.

while [[ ! -f "${SIGNAL_TO_STOP_FILE}" ]]; do # Repeats the loop while the file stoploop does not exist.
 echo "The file ${SIGNAL_TO_STOP_FILE} does not yet exist..." # Displays a message indicating that the file has not been found.
 echo "Checking again in 2 seconds..." # Displays a message saying the script will check again after 2 seconds.
 sleep 2 # Pauses the script for 2 seconds.
done # Ends the while loop.

echo "File was found! Exiting..." # Prints a message when the file is found and the loop ends.