#!/bin/bash

CURR_BRANCH=$( git rev-parse HEAD )
DIR_CHANGES=$( git show --name-only --pretty=oneline )
echo this is current branch $CURR_BRANCH
echo this is directory changes $DIR_CHANGES
echo this is comparison $( DIR_CHANGES == *"migrations/"* )

if [[ $DIR_CHANGES = *"migrations/"* ]]
then
  echo "It's there!"
  git clone https://github.com/IrfanBaqui/travis2
  cd travis2
  git checkout remotes/origin/latest_release
  # git checkout -b backward_compatibility_test
  git rm -r migrations
  git checkout remotes/origin/migration_change -- migrations
  npm install
  npm test;
fi

if [[ $DIR_CHANGES != *"/migrations"* ]]
then
  echo "It's NOT there!";
fi