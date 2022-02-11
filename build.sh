#!/bin/zsh

git add .
git commit -m "完善"
git push

git tag 1.0.1
git push --tags

pod trunk push QzUI.podspec --allow-warnings


# pod spec lint --allow-warnings
