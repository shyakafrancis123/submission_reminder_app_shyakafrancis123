#!/bin/bash

# Asking the user for a new assignment name
read -p "Kindly input the new assignment name: " new_assignment

# Finding the base directory (e.g., $basedir)
basedir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

# Ensure the directory exists
if [[ ! -d "$basedir" ]]; then
    echo " Error **** Didnt find the submission_reminder_ directory."
    exit 1
fi

# Updating the ASSIGNMENT in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$basedir/config/config.env"

echo " Assignment has been updated to \"$new_assignment\" in config.env"

# Running the  startup.sh from the $basedir
echo " Running the reminder check with the new assignment*******"
bash "$basedir/startup.sh"

