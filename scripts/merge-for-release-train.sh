# Fail if any commands fail
set -ex

INTEGRATION_BRANCH=develop

# Check if the INTEGRATION_BRANCH matches develop
if [[ "$BITRISE_GIT_BRANCH" == $INTEGRATION_BRANCH ]]; then
    echo "Proceeding with the build, you are merging develop into master. All your changes will be release on the next release train."
else
    echo "You are trying to merge any other branch than develop; you are not allowed to release a brnach without integrating to develop."

    # Skip Slack message
    envman add --key SKIP_OTHER_STEPS --value "true"
    exit 1
fi

# Get a local reference of the release branch
TARGET_RELEASE_BRANCH=master
git fetch origin $TARGET_RELEASE_BRANCH:$TARGET_RELEASE_BRANCH

# Merge integration branch (develop) into target branch (master)
echo "Merging $BITRISE_GIT_BRANCH into $TARGET_RELEASE_BRANCH"
git checkout $TARGET_RELEASE_BRANCH
git merge $BITRISE_GIT_BRANCH --no-ff --no-edit
git push origin HEAD
