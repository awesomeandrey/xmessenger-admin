#!/bin/bash

#Sample usage: bash scripts/create_scratch_org.sh -u dev

while getopts ":u:" opt; do
  case $opt in
    u)
        #Define context constants;
        export ORG_NAME=$OPTARG
        export TARGET_DEV_HUB_USERNAME=andrii.melnichuk@xmessenger.com
        #Create scratch org;
        sfdx force:org:create \
            -f config/project-scratch-def.json \
            -a ${ORG_NAME} \
            -v $TARGET_DEV_HUB_USERNAME &&
        #Push source to scratch org (cleaning '.forceignore' file);
        > .forceignore &&
        sfdx force:source:push -u ${ORG_NAME} -f &&
        #Create scratch org user;
        sfdx force:user:create \
            -u ${ORG_NAME} \
            -f config/dev-user-def.json \
            Username=${TARGET_DEV_HUB_USERNAME} &&
        #Open scratch org;
        sfdx force:org:open -u ${ORG_NAME}
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires target scratch org name." >&2
      exit 1
      ;;
  esac
done