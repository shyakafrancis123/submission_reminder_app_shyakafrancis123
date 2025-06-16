#!/bin/bash

# Prompt the user for a new assignment name
read -p "Enter the new assignment name: " new_assignment

# Find the correct base directory (e.g., submission_reminder_Meghan)
basedir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

# Ensure the directory exists
if [[ ! -d "$basedir" ]]; then
    echo " Error **** Didnt find the submission_reminder_ directory."
    exit 1
fi

# Update ASSIGNMENT in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$basedir/config/config.env"

echo " Assignment updated to \"$new_assignment\" in config.env"

# Run startup.sh from the base directory
echo " Running the reminder check with the new assignment..."
bash "$basedir/startup.sh"

