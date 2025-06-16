#!/bin/bash
cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Starting Reminder APP...."
check_submissions $submissions_file
