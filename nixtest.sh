if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
REPLAYKIT=./darwin/replaykit
else
REPLAYKIT=./linux/replaykit
fi
$REPLAYKIT version
$REPLAYKIT trace info test.trace || exit 1
$REPLAYKIT trace describe test.trace "may the force be with you" || exit 1
$REPLAYKIT trace info test.trace | grep force || exit 1
