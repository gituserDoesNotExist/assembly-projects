#!/bin/bash

logInfo='calculator-get-imports-recursively.sh: '
rootDir=$1
testFile=$2

if [ -z $rootDir ] || [ -z $testFile ]
then
	echo $logInfo 'insufficient number of parameters!'
	exit 2
fi

result=$(/usr/local/bin/get-imports-recursively.sh $rootDir $testFile)

echo $result | sed 's/found the following files: //g' | xargs -I {} echo {}
