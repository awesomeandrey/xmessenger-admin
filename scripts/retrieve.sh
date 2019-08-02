#!/usr/bin/env bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -u <target_username> -p <unmanaged_package_api_name>"
   echo -e "\t-u Target org username."
   echo -e "\t-p Unmanaged package name."
   exit 1 # Exit script after printing help;
}

while getopts "u:p:" opt
do
   case "$opt" in
      u ) targetOrgUsername="$OPTARG" ;;
      p ) unmanagedPackageName="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent;
   esac
done

# Print helpFunction in case parameters are empty;
if [[ -z "$targetOrgUsername" ]] || [[ -z "$unmanagedPackageName" ]]
then
   echo "Some or all of the parameters are empty.";
   helpFunction
fi

# Begin script in case all parameters are correct;
echo Target org username is: "$targetOrgUsername"
echo Unmanaged package API name is: "$unmanagedPackageName"

#Retrieve sources using Metadata API;
export tmp_dir=package
sfdx force:mdapi:retrieve \
    -s -r ${tmp_dir}/ \
    -u "$targetOrgUsername" \
    -p "$unmanagedPackageName" &&
unzip ${tmp_dir}/unpackaged.zip -d ${tmp_dir}/ &&
sfdx force:mdapi:convert -r ${tmp_dir}/ &&
rm -rf ${tmp_dir}