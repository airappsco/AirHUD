# These points can be either commit hashs or branch names
START_POINT=$1
END_POINT=$2

# Take the git log from $1 to $2 (can be either commit hash, branch or tag)
MERGE_HISTORY=$(git log $START_POINT...$END_POINT --merges --format=format:"----------%n%s%n%b%n----------")

# Process the git log to markdown
swift ./$SCRIPTS_DIRECTORY/generate-release-notes.swift "$MERGE_HISTORY" "" "$3"