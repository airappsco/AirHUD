function generate_release_notes {
    LATEST_VERSION=$(git tag -l --sort=-v:refname --no-contains=HEAD | grep "^\d\{1,\}\.\d\{1,\}\.\d\{1,\}\(\.\d\{1,\}\)*$" | head -n 1)
    if [ -z "$LATEST_VERSION" ]; then
        exit 0
    fi

    FORMAT=$1
    ./$SCRIPTS_DIRECTORY/generate-release-notes.sh $LATEST_VERSION HEAD $FORMAT
}