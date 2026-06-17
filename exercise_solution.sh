#!/bin/bash
NAME="${1}" # Stores the first command-line argument in the NAME variable.
DOMAIN="${2}" # Stores the second command-line argument in the DOMAIN variable.
OUTPUT_FILE="results.csv" # Creates a variable named OUTPUT_FILE containing the name of the output file where the results will be stored.

# Check if the two expected arguments are set
if [[ -z "${NAME}" ]] || [[ -z "${DOMAIN}" ]]; then # Checks whether either variable is empty. If either NAME or DOMAIN is empty, the if block is executed.
  echo "You must provide two arguments to this script." # Displays the message: You must provide two arguments to this script.
  echo "Example: ${0} mysite nostarch.com" # Displays an example of how to run the script. ${0} contains the script's filename.
  exit 1 # Stops the script and returns an error status.
fi # Ends the if statement.

# Write CSV header to the file
echo "status,name,domain,timestamp" > ${OUTPUT_FILE} # Writes the CSV header. The > operator creates the file or overwrites it if it already exists.

if ping -c 1 "${DOMAIN}" &> /dev/null; then # Runs a ping command to test the domain.
  echo "success,${NAME},${DOMAIN},$(date)" >> "${OUTPUT_FILE}" #  If the ping succeeds, appends a new line to the CSV file. >> appends to the end of the file. $(date) inserts the current date and time.
else # Runs when the ping fails.
  echo "failure,${NAME},${DOMAIN},$(date)" >> "${OUTPUT_FILE}" # Writes a line indicating that the domain did not respond.
fi # Ends the second if statement.
