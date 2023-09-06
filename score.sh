#!/bin/bash

flag=$1

if [ "$flag" == "--unzip" ]; then
  for file in *.zip
  do 
	file_name=${file:0:9}
	unzip $file -d $file_name
  done
exit 1
fi






if [ "$flag" == "--lint" ]; then
echo -n > 'lint_result'

for folder in `ls -d */ `
do 

  ##cpplint
  cd $folder
  echo $folder
  `cpplint --filter=-legal/copyright *.cc`
  if [ $? -eq 0 ]
	then
	  echo $folder 'lint err' >> '../lint_result'
	else
	  lint_res=`cpplint --filter=-legal/copyright *.cc *.h 2> /dev/null | grep errors`
	  if [ -z "$lint_res" ]; then
		lint_res='Total errors found: 0'
	  fi
	  echo $folder ${lint_res/Total errors found: /} >> '../lint_result'
  fi
  cd ..
done
exit 1
fi






if [ "$flag" == "--help" ]; then
  echo "--unzip : unzip all .zip files"
  echo "--lint : run cpp lint for each folder"
exit 1
fi

echo "unknown option. --help"
exit 0
