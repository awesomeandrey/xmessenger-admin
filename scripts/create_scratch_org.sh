#!/usr/bin/env bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -a <scratch_org_alias> -u <target_dev_hub_username> "
   echo -e "\t-a Scratch org alias."
   echo -e "\t-u Connected DevHub username."
   exit 1 # Exit script after printing help;
}

while getopts "a:u:" opt
do
   case "$opt" in
      a ) scratchOrgAlias="$OPTARG" ;;
      u ) devHubUsername="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent;
   esac
done

# Print helpFunction in case parameters are empty;
if [[ -z "$scratchOrgAlias" ]] || [[ -z "$devHubUsername" ]]
then
   echo "Some or all of the parameters are empty.";
   helpFunction
fi

# Execute rest of script in case all parameters are correct;
echo Scratch org alias: "$scratchOrgAlias"
echo DevHub username: "$devHubUsername"

#Create scratch org;
sfdx force:org:create \
    -f config/project-scratch-def.json \
    -a "$scratchOrgAlias" \
    -v "$devHubUsername" &&

#Push source to scratch org (cleaning '.forceignore' file);
> .forceignore &&
echo "force-app/main/default/sites/xMessenger_Support_Chat.site-meta.xml" >> .forceignore &&
sfdx force:source:push \
    -u "$scratchOrgAlias" \
    -f &&

#Configure default scratch org user with required permission(s);
key_value_array=($(sfdx force:user:display -u "$scratchOrgAlias" | grep "Username"))
default_username=${key_value_array[1]}
declare -a permissionSetNames=("xMessenger_Admin" "Chat_Support")
for i in "${permissionSetNames[@]}"
do
   sfdx force:user:permset:assign --permsetname ${i} --targetusername ${default_username}
done

#Create scratch org test user;
sfdx force:user:create \
    -u "$scratchOrgAlias" \
    -f config/dev-user-def.json &&

#Open scratch org;
sfdx force:org:open -u "$scratchOrgAlias"
echo "You can start coding!"