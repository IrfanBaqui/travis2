#!/bin/bash
git add .
git commit -m "changed travis setup"
git checkout develop
git merge migration_change
git checkout no_migration_change
git merge develop
git checkout latest_release 
git merge develop
git push origin latest_release develop migration_change no_migration_change
