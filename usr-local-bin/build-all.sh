#!/bin/bash
#pass rootDirectory. Assembles files in rootDir/src/main and copies them to /rootDir/target/object-files where they are linked into 'result'

logInfo='build-all.sh: '
rootDir=$1

if [ -z $rootDir ]
then
	echo $logInfo 'you should specify a rootDirectory containing .asm files'
	exit 2
fi

if [ ! -d $rootDir ]
then
	echo $logInfo $rootDir 'is not a valid rootDirectory'
	exit 2
fi

echo $logInfo 'start to assemble files'
sh /usr/local/bin/assemble-all.sh $rootDir
status=$?
if [ ! $status -eq 0 ]
then
	echo '##############################################'
	echo $logInfo 'ERROR DURING ASSEMBLING FILES'
	echo '##############################################'
	exit 2
fi


echo $logInfo 'linking generated object files'
sh /usr/local/bin/link-all.sh $rootDir
status=$?
if [ ! $status -eq 0 ]
then
	echo '##############################################'
	echo $logInfo 'ERROR DURING LINKING FILES'
	echo '##############################################'
	exit 2
fi
