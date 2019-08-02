#!/usr/bin/env bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -u <target_username> "
   echo -e "\t-u Target org username."
   exit 1 # Exit script after printing help;
}

while getopts ":u:" opt
do
   case "$opt" in
      u ) targetOrgUsername="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent;
   esac
done

# Print helpFunction in case parameters are empty;
if [[ -z "$targetOrgUsername" ]]
then
   echo "Some or all of the parameters are empty.";
   helpFunction
fi

# Begin script in case all parameters are correct;
echo Target org username is: "$targetOrgUsername"

#Deploy via Metadata API;
export tmp_dir=mdapioutput
sfdx force:org:display -u $"$targetOrgUsername" &&
sfdx force:source:convert -d ${tmp_dir}/ &&
sfdx force:mdapi:deploy \
    -d ${tmp_dir}/ \
    -u $"$targetOrgUsername" \
    -w 100 &&
rm -rf ${tmp_dir} &&

#Run all tests in org;
sfdx force:apex:test:run -u $"$targetOrgUsername" --wait 10