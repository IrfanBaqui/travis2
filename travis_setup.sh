#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print shell input lines as they are read
set -v

# Run tests
npm test

CURR_BRANCH=$( git rev-parse HEAD )
git branch -a
echo CURR_BRANCH
# git rev-parse remotes/origin/latest_release
# git rev-parse remotes/origin/migration_change
DIR_CHANGES=$( git show --name-only --pretty=oneline )

# if [[ $DIR_CHANGES = *"migrations/"* ]]
# then
  # echo "It's there!"
  git clone https://github.com/IrfanBaqui/travis2
  cd travis2
  git checkout remotes/origin/latest_release
  git diff --name-status --color remotes/origin/latest_release..remotes/origin/migration_change
  git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master)
  git diff --name-only $CURR_BRANCH
  # git checkout -b backward_compatibility_test
  git rm -r migrations
  git checkout remotes/origin/migration_change -- migrations
  ls
  cat ./migrations/migrations_file.js
  echo "syntax error" >> ./migrations/migrations_file.js
  cat ./migrations/migrations_file.js
  npm install
  npm test;
# fi

exit 0