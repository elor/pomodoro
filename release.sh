#!/bin/bash

set -e -u

git checkout master
npm run build
git add pomodoro/
git commit -m 'Build'
git push

git branch -D gh-pages
git checkout -b gh-pages

git rm babel.config.js  LICENSE package.json README.md vue.config.js src/ public/ -r
git mv pomodoro/* ./
rmdir pomodoro

git push --force github gh-pages
