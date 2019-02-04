#! /bin/bash

if [ "$CIRCLE_BRANCH" == "master" ]; then
  mvn sonar:sonar \
    -Dsonar.projectKey=colorcodecanvas_circlesonar \
    -Dsonar.organization=colorcodecanvas \
    -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.login=218a21bec532782bc07312d4ff869ea329e21171
else
  echo circle ci master commit head bug fix defined in https://community.sonarsource.com/t/code-is-empty-on-pull-request-reviews/822
  git fetch --all
  git branch -D master
  git rev-parse origin/master
  mvn sonar:sonar \
    -Dsonar.projectKey=colorcodecanvas_circlesonar \
    -Dsonar.organization=colorcodecanvas \
    -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.login=218a21bec532782bc07312d4ff869ea329e21171 \
    -Dsonar.pullrequest.base=master \
    -Dsonar.pullrequest.key=${CI_PULL_REQUEST##*/} \
    -Dsonar.pullrequest.branch="$CIRCLE_BRANCH" \
    -Dsonar.pullrequest.provider=github \
    -Dsonar.pullrequest.github.repository="$CIRCLE_PROJECT_REPONAME" \
    -Dsonar.pullrequest.github.endpoint=https://api.github.com/
fi