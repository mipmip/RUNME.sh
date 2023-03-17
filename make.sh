#!/usr/bin/env sh
source ./src/RUNME.inc.minified.sh

makescript(){
  outfile=$1
  minify=$2
  echo $outfile

  echo "#!/usr/bin/env bash" > $outfile
  echo "#(C)2019-2022 Pim Snel - https://github.com/mipmip/RUNME.sh" >> $outfile

  if $minify; then
    #curl -s https://raw.githubusercontent.com/Zuzzuc/Bash-minifier/8a8626022fbd2e6450de2d0f38b425657dba6d01/Minify.sh | bash -s -- -F -f=./src/RUNME.inc.sh >> $outfile
    cat ./src/RUNME.inc.minified.sh >> $outfile
  else
    cat ./src/RUNME.inc.sh >> $outfile
  fi
  cat ./src/RUNME.tpl.sh >> $outfile
  chmod +x $outfile

}

make_command "make" "make release and minified version"
make(){
  makescript "./RUNME.unminified.sh" false
  makescript "./RUNME.sh" true
}



runme
