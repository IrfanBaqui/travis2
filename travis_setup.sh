#!/bin/bash

CURR_BRANCH=$( git rev-parse HEAD )
DIR_CHANGES=$( git show --name-only --pretty=oneline )

if [[ DIR_CHANGES == *"/migrations"* ]]
then
  echo "It's there!";
  git clone https://github.com/IrfanBaqui/travis2
  cd travis
  git checkout latest_release
  git checkout -b backward_compatibility_test
  git rm -r migrations
  git checkout remotes/origin/migration_change -- migrations
  npm install
  npm test
fi