if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
 ./darwin/appetizer version
else
 ./linux/appetizer version
fi
