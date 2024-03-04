#!/usr/bin/env bash
# exit on error
set -o errexit

cd backend
bundle install
bundle exec rails db:migrate
