#!/usr/bin/env sh
echo "#!/usr/bin/env sh" > ./RUNME.sh
echo "#(C)2019-2022 Pim Snel - https://github.com/mipmip/RUNME.sh" >> ./RUNME.sh
#curl -s https://raw.githubusercontent.com/Zuzzuc/Bash-minifier/8a8626022fbd2e6450de2d0f38b425657dba6d01/Minify.sh | bash -s -- -F -f=./src/RUNME.inc.sh >> ./RUNME.sh
cat ./src/RUNME.inc.minified.sh >> ./RUNME.sh
cat ./src/RUNME.tpl.sh >> ./RUNME.sh
