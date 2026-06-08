#!/bin/bash

# This script will ping any address provided as an argument.

SCRIPT_NAME="${0}"
TARGET="${1}"

echo "Running the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping -c 3 "${TARGET}"

#chmod u+x ping_with_arguments.sh
#./ping_with_arguments.sh nostarch.com

echo "The arguments are: $@"
echo "The total number of arguments is: $#"

# Change "$@" to "$*" to observe behavior.
for args in "$@"; do
 echo "${args}"
done

