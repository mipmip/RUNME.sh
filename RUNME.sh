#!/usr/bin/env sh
. ./.runme.sh

make_command "demo" "this command is for explaining how run-me works"
demo(){
  echo "showing the current directory"
  ls -al
}

runme
