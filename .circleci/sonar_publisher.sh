#! /bin/bash

MASTER_CODE_ANALYSIS_CMD="mvn sonar:sonar \
    -Dsonar.projectKey=colorcodecanvas_circlesonar \
    -Dsonar.organization=colorcodecanvas \
    -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.login=218a21bec532782bc07312d4ff869ea329e21171"


PR_CODE_ANALYSIS_CMD="$MASTER_CODE_ANALYSIS_CMD \
    -Dsonar.pullrequest.base=master \
    -Dsonar.pullrequest.key=${CI_PULL_REQUEST##*/} \
    -Dsonar.pullrequest.branch="$CIRCLE_BRANCH" \
    -Dsonar.pullrequest.provider=github \
    -Dsonar.pullrequest.github.repository=$CIRCLE_PROJECT_REPONAME \
    -Dsonar.pullrequest.github.endpoint=https://api.github.com/"

analyze_master() {
  $MASTER_CODE_ANALYSIS_CMD
}

analyze_pr() {
  git fetch --all
  git branch -D master
  git rev-parse origin/master
  $PR_CODE_ANALYSIS_CMD
}

if [ "$CIRCLE_BRANCH" == "master" ]; then is_master=1; else is_master=0; fi;
if [ -z ${CI_PULL_REQUEST+x} ]; then is_pr=1; else is_pr=0; fi
if [ $is_master eq 1 -o $is_pr eq 1 ]; then
  mvn clean test
  $is_master && analyze_master || analyze_pr
else
  echo "Skipping CI for non master or non PR branch - $CIRCLE_BRANCH"
fi