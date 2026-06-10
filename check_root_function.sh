#!/bin/bash

# This function checks if the current user ID equals zero.
check_if_root(){ # Defines a function named check_if_root.
if [[ "${EUID}" -eq "0" ]]; then # Checks whether the effective user ID (EUID) is equal to 0.
 return 0  # Returns success from the function. 0 = success
 else # Executes if the condition is false.
 return 1 # Returns failure from the function. 1 = error or false
 fi # Ends the if statement.
} # Ends the function definition.

if check_if_root; then # Calls the function and checks its return value. If the function returns 0, the condition is true.
 echo "User is root!" # Prints a message indicating the user is root.
else # Executes if the function returns a non-zero value.
 echo "User is not root!" # Prints a message indicating the user is not root.
fi # Ends the final if statement.


# Change root to user
useradd -m # Sammy Creates a new user named Sammy and automatically creates a home directory for that user.
su - Sammy # Switches to the user Sammy and starts a login shell with that user's environment.
