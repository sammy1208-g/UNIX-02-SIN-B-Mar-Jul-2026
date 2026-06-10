#!/bin/bash
USER_INPUT="${1}" # Stores the first command-line argument in the variable USER_INPUT.
if [[ -z "${USER_INPUT}" ]]; then # Checks if the variable USER_INPUT is empty.
 echo "You must provide an argument!" # Displays a message telling the user that an argument is required.
 exit 1 # Stops the script and returns an error code (1).
fi # Ends the first if statement.
if [[ -f "${USER_INPUT}" ]]; then # Checks whether the input is a regular file.
 echo "${USER_INPUT} is a file." # Prints that the input is a file.
elif [[ -d "${USER_INPUT}" ]]; then # Checks whether the input is a directory if it is not a file.
 echo "${USER_INPUT} is a directory." # Prints that the input is a directory.
else # Executes when none of the previous conditions are true.
 echo "${USER_INPUT} is not a file or a directory." # Prints that the input is neither a file nor a directory.
fi # Ends the second if statement.
