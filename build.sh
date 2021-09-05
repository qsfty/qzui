#!/bin/zsh

git add .
git commit -m "完善"
git push

git tag 0.0.15
git push --tags

pod trunk push qzui.podspec --allow-warnings


# pod spec lint --allow-warnings