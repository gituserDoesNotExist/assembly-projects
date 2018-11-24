#!/bin/bash
#first parameter: name of file in which imports are searched

logInfo='get-imports.sh: '
file=$1

if [ -z $file ]
then
	echo $logInfo 'you should pass a filename!'
	exit 2
fi

if [ ! -f $file ]
then
	echo $logInfo 'entered file does not exist!'
	exit 2
fi

grep '^\s*extern\s[\w\d]*' $file | sed 's/extern //g' | xargs -I {} echo {}
