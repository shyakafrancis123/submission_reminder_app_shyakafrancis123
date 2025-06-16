#!/bin/bash

# Ask for the username
read -p "Kindly insert your name: " username

# Define the base directory
basedir="submission_reminder_${username}"

# Making the directories and arranging the tree
mkdir -p "$basedir/config"
mkdir -p "$basedir/modules"
mkdir -p "$basedir/app"
mkdir -p "$basedir/assets"

# Creating the subfiles
cat <<EOF > "$basedir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create and populate functions.sh
cat <<'EOF' > "$basedir/modules/functions.sh"
#!/bin/bash
# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
   done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Populate reminder.sh
cat <<'EOF' > "$basedir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Populate startup.sh
cat <<'EOF' > "$basedir/startup.sh"
#!/bin/bash
cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Starting Reminder APP...."
check_submissions $submissions_file
EOF

# Populate submissions.txt with original + 5 more students
cat <<EOF > "$basedir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Shyaka, Git, not submitted
Grace, Shell Basics, submitted
Brian, Shell Navigation, submitted
Teta, Git, submitted
Gyslene, Shell Basics, not submitted
Mugisha, Shell Navigation, not submitted
Mylene, Git, not submitted
Jospine, Shell Basics, submitted
Kami, Git, submitted
Meghan, Shell Navigation, submitted
EOF

# Making all .sh files executable
find "$basedir" -type f -name "*.sh" -exec chmod +x {} \;

# Completion statement
echo "The working environment has been successfully created in $basedir"
