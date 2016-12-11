if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
 ./appetizer-toolkit-darwin-x64 version
else
 ./appetizer-toolkit-linux-x64 version
fi
