#!/bin/bash

for file in example_file*; do # Starts a for loop. The variable file takes, one by one, every file whose name starts with example_file.
    if [[ "${file}" == "example_file1" ]]; then # Checks whether the current file is example_file1. If the condition is true, it executes the if block.
        echo "Skipping the first file" # Displays the message "Skipping the first file."
        continue # Skips the rest of the current loop iteration and moves to the next file.
    fi # Ends the if statement.
    echo "${RANDOM}" > "${file}" #Generates a random number using the RANDOM variable and writes it into the current file, replacing its contents. 
done # Ends the for loop.
