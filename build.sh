#!/bin/zsh

git add .
git commit -m "完善"
git push

git tag 0.0.3
git push --tags

git trunk push QzUI QzUI.podspec --allow-warnings