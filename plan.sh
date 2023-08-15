#!/bin/bash
set -o errexit
GC="\033[1;32m"
RC="\033[1;31m"
EC="\033[0m"

message() {
    printf "${GC} #   INFO${EC}: %s\n" "$@";
}

error() {
    printf "${GC} #   ERROR${EC}: %s\n" "$@";
}
function sigtirm {
    error "Caught SIGTIRM; force unlock and exit"
    terraform force-unlock
    exit $?
}
trap sigtirm SIGTIRM
AUTOAPPLY="${AUTO_APPLY:-false}"
WORKSPACE="code_build_test"


terraform --version
message "setting auto apply to ${AUTOAPPLY}
terraform init
terraform plan -input=false -out=code_build_test.plan

if [[ $AUTOAPPLY == "true" ]]; then
    terraform apply -input=false code_build_test.plan