# Collects release notes suitable for being sent as Github release notes (PRs and Jira tickets)
# It takes the notes by git logging the difference from the last published tag with the HEAD of current branch
#
# Required env vars:
#   SCRIPTS_DIRECTORY - path to the scripts directory relative to project root
#   BUILD_VERSION - the current build number
#   BITRISE_GIT_BRANCH - the current working branch of Bitrise
# Result:
#   The release notes are set to the APP_STORE_CONNECT_RELEASE_NOTES env var
#   BITRISE_RELEASE_VERSION is set to the current build number
#   BITRISE_TARGET_RELEASE_BRANCH is set to the current branch
function generate_release_notes {
    echo "Fetching all tags from remote repository"
    git fetch --all --tags

    source ./$SCRIPTS_DIRECTORY/release-notes-utils.sh
    RELEASE_NOTES=$(generate_release_notes github)

    echo "Setting BITRISE_RELEASE_NOTES=${RELEASE_NOTES}"
    envman add --key BITRISE_RELEASE_NOTES --value "${RELEASE_NOTES}"

    echo "Setting BITRISE_RELEASE_VERSION=${BUILD_VERSION}"
    envman add --key BITRISE_RELEASE_VERSION --value "${BUILD_VERSION}"

    echo "Setting BITRISE_TARGET_RELEASE_BRANCH=${BITRISE_GIT_BRANCH}"
    envman add --key BITRISE_TARGET_RELEASE_BRANCH --value "${BITRISE_GIT_BRANCH}"
}

generate_release_notes