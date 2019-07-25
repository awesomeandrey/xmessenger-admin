#!/bin/bash

#Sample usage: bash scripts/create_scratch_org.sh -u dev

while getopts ":u:" opt; do
  case $opt in
    u)
        #Defined context constants;
        export ORG_NAME=$OPTARG
        export TARGET_USERNAME=andrii.melnichuk@xmessenger.com
        export DEFAULT_PERM_SET=Heroku_Integrator
        #Create scratch org;
        sfdx force:org:create -f config/project-scratch-def.json -a $ORG_NAME --targetdevhubusername $TARGET_USERNAME
        #Push source to scratch org (cleaning up .forceignore file);
        echo "force-app/main/default/profiles" > .forceignore
        echo "force-app/main/default/appMenus/AppSwitcher.appMenu-meta.xml" >> .forceignore
        sfdx force:source:push -u $ORG_NAME -f
        #Assign permission set;
        sfdx force:user:permset:assign --permsetname $DEFAULT_PERM_SET --targetusername $TARGET_USERNAME -u $ORG_NAME
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