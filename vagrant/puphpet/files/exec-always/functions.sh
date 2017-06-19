#!/bin/bash

function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/4;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

function copy_ssh_keys {
  # Copy each public key in a directory full of public key files to the
  # authorized_keys file assuring no keys are removed or duplicated.
  #
  # Input:
  #   $1 - The path to a directory containing ssh public keys, with one key per file.
  #   Each key must have a unique comment.  Each file must match the pattern *.pub.
  #   Subdirectories are *not* recursed.
  #
  #   $2 - The path for the authorized keys file.
  #
  # Output:
  #   a single file, ~/.ssh/authorized_keys, containing one copy of each unique key
  #   in the input directory along with every key that was already in ~/.ssh/authorized_keys
  #   Deduplication is done across the existing ~/.ssh/authorized_keys and the files in
  #   the input directory.
  #
  #   A backup of the ~/.ssh/authorized_keys at ~/.ssh/authorized_keys.backup
  #
  local keydir=$1
  local TARGET_FILE=~/.ssh/authorized_keys
  local TARGET_FILE=$2
  TMP_FILE=tmp.pubkey
  if [ -d $keydir ]; then
    # make a backup of the target file
    if [ -e $TARGET_FILE ]; then
      cp $TARGET_FILE $TARGET_FILE.backup
    fi

    # Make sure the target file's parent directory exists
    PARENT_DIR=`echo $TARGET_FILE | sed -e "s/\(^.*\/\).*/\1/;"`
    mkdir -p $PARENT_DIR

    # Append each new key and remove duplicates
    for key in $( ls -1 $keydir/*.pub ) ; do
      cp $key $TMP_FILE
      touch $TARGET_FILE
      sed -i.bak -e "/$(awk '{print $NF}' $TMP_FILE)/d" $TARGET_FILE
      cat $TMP_FILE >> $TARGET_FILE
      rm $TMP_FILE
    done

  else
    echo "Directory of SSH Keys, $keydir, does not exist"
  fi
}
