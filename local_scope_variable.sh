#!/bin/bash
set -x
# Global variable. It can be accessed from anywhere in the script, including functions.
# Global variables are useful when information needs to be shared throughout the program.
PUBLISHER="No Starch Press"

# This function displays the name of the book and its publisher.
print_name(){

 # Local variable. It exists only inside this function.
  # Local variables help prevent conflicts with variables used elsewhere in the script.
 local name

 name="Black Hat Bash"
 echo "${name} by ${PUBLISHER}"
}
# Function call.
print_name

#The variable 'name' will not be printed because it is local to the function.
# Once the function finishes, the variable is no longer accessible.
echo "Variable ${name} will not be printed because it is a local variable."

set +x
