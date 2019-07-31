#!/bin/bash

#Sample usage: bash scripts/create_scratch_org.sh -u dev

while getopts ":u:" opt; do
  case $opt in
    u)
        #Define context constants;
        export ORG_NAME=$OPTARG
        export TARGET_USERNAME=andrii.melnichuk@xmessenger.com
        #Create scratch org;
        sfdx force:org:create -f config/project-scratch-def.json -a $ORG_NAME --targetdevhubusername $TARGET_USERNAME &&
        #Push source to scratch org (cleaning up .forceignore file);
        echo "**liveChat" > .forceignore
        echo "**permissionsets" >> .forceignore
        sfdx force:source:push -u $ORG_NAME -f &&
        sed -i "/permissionsets/d" .forceignore &&
        sfdx force:source:push -u $ORG_NAME -f &&
        #Assign permission sets;
        sfdx force:user:permset:assign --permsetname Heroku_Integrator --targetusername $TARGET_USERNAME -u $ORG_NAME &&
        sfdx force:user:permset:assign --permsetname Chat_Support --targetusername $TARGET_USERNAME -u $ORG_NAME &&
        #Open scratch org;
        sfdx force:org:open -u $ORG_NAME
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