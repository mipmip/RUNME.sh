#/bin/sh
source ./rake.sh

make_command "demo" "this command is for explaining how minimake works"
demo(){
  echo "showing the current directory"
  ls -al
}

run
