#!/bin/bash
while getopts ":u:" opt; do
  case $opt in
    u)
        export ORG_NAME=$OPTARG
        #Deploy via Metadata API;
        export tmp_dir=mdapioutput
        sfdx force:org:display -u $ORG_NAME &&
        sfdx force:source:convert -d $tmp_dir/ &&
        sfdx force:mdapi:deploy \
            -d $tmp_dir/ \
            -u $ORG_NAME \
            -w 100 &&
        rm -rf $tmp_dir &&
        #Run all tests in org;
        sfdx force:apex:test:run -u $ORG_NAME --wait 10
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires target org name." >&2
      exit 1
      ;;
  esac
done