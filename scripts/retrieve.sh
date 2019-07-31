#!/bin/bash
while getopts ":u:" opt; do
  case $opt in
    u)
        export USERNAME=$OPTARG
        #Unmanaged package name (static value);
        export STATIC_PACKAGE_NAME=sfdxTransfer
        export tmp_dir=package
        sfdx force:mdapi:retrieve -s -r $tmp_dir/ -u $USERNAME -p $STATIC_PACKAGE_NAME &&
        unzip $tmp_dir/unpackaged.zip -d $tmp_dir/ &&
        sfdx force:mdapi:convert -r $tmp_dir/ &&
        rm -rf $tmp_dir
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