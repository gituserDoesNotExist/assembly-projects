#!/bin/bash

logInfo='test-build-runnable-and-run.sh :'
rootDir=$1
testFile=$2

if [ -z $testFile ]
then
	echo $logInfo 'you should pass the name of the test file'
	exit 2
fi

/usr/local/bin/get-imports-recursively.sh $rootDir $testFile
status=$?
if [ $status -ne 0 ]
then
	echo '###################################################'
	echo $logInfo 'error during determining imports!'
	echo '##################################################'
	exit 2
fi

filesToLink=$(/usr/local/bin/get-imports-recursively.sh $rootDir $testFile)

echo $logInfo 'found the following files for linking:'
for value in  ${filesToLink[@]}
do
	echo '    '$value
done

/usr/local/bin/test-assemble-all.sh $rootDir
status=$?
if [ $status -eq 0 ]
then
	echo $logInfo 'successfully assembled files'
else
	echo '##############################################'
	echo $logInfo 'ERROR DURING ASSEMBLING FILES'
	echo '##############################################'
	exit 2
fi


/usr/local/bin/test-link-all.sh $rootDir ${filesToLink[@]}

status=$?
if [ $status -eq 0 ]
then
	echo $logInfo 'successfully linked files'
	echo $logInfo 'test file is: ' $rootDir'/test-candidate'
else
	echo '##############################################'
	echo $logInfo 'ERROR DURING CREATING RESULT'
	echo '##############################################'
	exit 2
fi

echo '---------------------------starting test--------------------------------'
echo $logInfo ' starting test by executing "test-candiate"'

$rootDir/test-candidate
