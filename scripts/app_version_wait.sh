#!/bin/bash

#~ default values
DEFAULT_TARGET=http://localhost:8000/en
DEFAULT_VERSION=${2:-undef}

#~ input values
QA_BRANCH=$1
TARGET_ENDPOINT=${TARGET_ENDPOINT:-$DEFAULT_TARGET}
EXPECTED_VERSION=${EXPECTED_VERSION:-$DEFAULT_VERSION}

#~ managed values
declare -A managedBranchesEnv
managedBranchesEnv=( ["feature/ntQA"]="https://new-theme.staging.geokrety.org/en" ["feature/new-theme"]="https://new-theme.staging.geokrety.org/en")
if [[ ( "${QA_BRANCH}" != "" ) && ( "${managedBranchesEnv[${QA_BRANCH}]}" != "" ) ]];  then
  TARGET_ENDPOINT=${managedBranchesEnv[${QA_BRANCH}]}
fi

#~ working values
TARGET_URL=${TARGET_ENDPOINT}/app-version
ITERATION_RETRY_SLEEP=1
ITERATION_MAX=60
ITERATION=0
LAST_VERSION=
CURRENT_VERSION=

function getCurrentHash() {
  DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
  CURRENT_VERSION=$(curl -s $TARGET_URL)
  CURL_STATUS=$?
  if [ ${CURL_STATUS} != 0 ] ; then
    echo "${DATETIME} endpoint not ready (${CURL_STATUS})"
  elif [[ "${CURRENT_VERSION}" != "${LAST_VERSION}" ]] ; then
    echo "${DATETIME} current version is: '${CURRENT_VERSION}'"
    LAST_VERSION=${CURRENT_VERSION}
  else
    echo "${DATETIME}"
  fi
}

echo " * now waiting for '${EXPECTED_VERSION}' from ${TARGET_URL}"

while [[ ( "${CURRENT_VERSION}" != "${EXPECTED_VERSION}" ) && ( ${ITERATION} -lt ${ITERATION_MAX} ) ]]
do
    if [ ${ITERATION} -ne 0 ]; then
      sleep ${ITERATION_RETRY_SLEEP}
    fi
    getCurrentHash
    if [[ "${CURRENT_VERSION}" != "${EXPECTED_VERSION}" ]]; then
      ITERATION=$((ITERATION + 1))
    fi
done
if [[ "${CURRENT_VERSION}" != "${EXPECTED_VERSION}" ]]; then
   echo "${DATETIME} endpoint not ready after ${ITERATION_MAX} iterations"
   # TODO : remove me when staging will provided /app-version
   exit 0
   # exit 1;# failure
fi
