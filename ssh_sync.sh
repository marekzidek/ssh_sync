#!/usr/bin/env sh

current_path=$(pwd)
ssh_dir='/'
ssh_key='/lol.pem'
ssh_user_address=''

if [ -f .ssh_sync ]; then 
  . ./.ssh_sync
else
  echo 'ssh_dir:'
  read ssh_dir 
  echo "ssh_dir=\"$ssh_dir\"\n" >> .ssh_sync
  echo 'ssh_key:'
  read ssh_key 
  echo "ssh_key=\"$ssh_key\"\n" >> .ssh_sync
  echo 'ssh_user_address:'
  read ssh_user_address
  echo "ssh_user_address=\"$ssh_user_address\"\n" >> .ssh_sync


fi

new_file=$1
new_path=${new_file#$current_path/}
source_path="$current_path"/"$new_path"
echo "$source_path"
new_dir=$(dirname "$new_path")
echo "$ssh_dir"
echo "$ssh_dir"/"$new_path"

ssh -i $ssh_key "$ssh_user_address" -- mkdir -p "$ssh_dir"/"$new_dir"
scp -i $ssh_key "$source_path" "$ssh_user_address":"$ssh_dir"/"$new_path" &&
    echo "Transferred: $new_path"
