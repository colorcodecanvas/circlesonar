#! /bin/bash

TRUE=0
FALSE=1

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

if [ "$CIRCLE_BRANCH" == "master" ]; then is_master=$TRUE; else is_master=$FALSE; fi;
if [ -z ${CI_PULL_REQUEST+x} ]; then is_pr=$FALSE; else is_pr=$TRUE; fi
if [ $is_master -eq $TRUE -o $is_pr -eq $TRUE ]; then
  [[ $is_master -eq $TRUE ]] && analyze_master || analyze_pr
else
  echo "Skipping CI for non master or non PR branch - $CIRCLE_BRANCH. Configure circleci to only build PR branches!"
fi