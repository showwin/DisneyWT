#!/bin/bash
FILENAME='deploy/cold'

echo "----- bundle exec cap production deploy:stop ----- "
bundle exec cap production deploy:stop
echo "----- bundle exec cap production deploy BRANCH=master ----- "
bundle exec cap production deploy BRANCH=master
