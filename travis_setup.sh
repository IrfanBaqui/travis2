#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print shell input lines as they are read
set -v

# Run tests
npm test

if [[ !$TRAVIS_PULL_REQUEST ]] && [[ $DIR_CHANGES = *"migrations/"* ]]
then

	CURR_BRANCH=$( git rev-parse HEAD )
	echo $TRAVIS_BRANCH #migration_change
	echo $TRAVIS_COMMIT
	echo $TRAVIS_PULL_REQUEST
	echo $TRAVIS_TAG

	# git rev-parse remotes/origin/latest_release
	# git rev-parse remotes/origin/migration_change
	DIR_CHANGES=$( git show --name-only --pretty=oneline )

	# if [[ $DIR_CHANGES = *"migrations/"* ]]
	# then
	  # echo "It's there!"
	  git clone https://github.com/IrfanBaqui/travis2
	  cd travis2
	  git checkout remotes/origin/latest_release
	  # git diff --name-status --color remotes/origin/latest_release..remotes/origin/migration_change
	  git diff --name-status --color remotes/origin/develop..$CURR_BRANCH
	  # git checkout -b backward_compatibility_test
	  git rm -r migrations
	  # git checkout remotes/origin/migration_change -- migrations
	  git checkout $CURR_BRANCH -- migrations
	  ls
	  cat ./migrations/migrations_file.js
	  # echo "syntax error" >> ./migrations/migrations_file.js
	  cat ./migrations/migrations_file.js
	  npm install
	  npm test;
	# fi
fi

exit 0