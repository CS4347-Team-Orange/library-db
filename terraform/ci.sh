#!/usr/bin/env bash

set -eou pipefail

if [[ "${TRAVIS_PULL_REQUEST}" == "false" && "${TRAVIS_BRANCH}" == "master" ]]; then
    stage="live"
elif [[ "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
    stage="${TRAVIS_BRANCH}"
elif [[ "${TRAVIS_PULL_REQUEST}" == "true" ]]; then
    stage="${TRAVIS_PULL_REQUEST_BRANCH}" # The source branch
else 
    echo "TRAVIS_PULL_REQUEST has unexpected value: ${TRAVIS_PULL_REQUEST}"
    exit 1
fi

TF_WORKSPACE="library-db-${stage}"

mkdir -p ~/.terraform.d/
echo "{\"credentials\": {\"app.terraform.io\": {\"token\": \"$TF_API_TOKEN\"}}}" > ~/.terraform.d/credentials.tfrc.json

echo "stage = \"${stage}\"" > ./ci.auto.tfvars
echo "container_uri = \"${container_uri}\"" >> ./ci.auto.tfvars
echo "tf_account_workspace = \"library-${stage}\"" >> ./ci.auto.tfvars
echo "tf_org = \"${TF_ORG}\"" >> ./ci.auto.tfvars

cp config.remote.tfbackend.tpl config.remote.tfbackend
sed -i "s#TF_ORG#${TF_ORG}#g" config.remote.tfbackend
sed -i "s#TF_WORKSPACE#${TF_WORKSPACE}#g" config.remote.tfbackend
sed -i "s#TF_HOST#${TF_HOST}#g" config.remote.tfbackend 

terraform init -backend-config="config.remote.tfbackend"
terraform plan
terraform apply -auto-approve