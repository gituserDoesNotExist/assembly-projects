#!/bin/bash
#pass root rootDirectory. Links all files found in rootDir/target/object-files

logInfo='link-all.sh :'
rootDir=$1

if [ -z $rootDir ]
then
	echo $logInfo 'you should pass the rootDirectory'
	exit 2
fi
if [ ! -d $rootDir ]
then
	echo $logInfo $rootDir 'is not a valid rootDirectory'
	exit 2
fi

cd $rootDir
dirObjectFiles=$(pwd)/target/object-files

if [ ! -d $dirObjectFiles ]
then
	echo $logInfo $dirObjectFiles ' does not exist. No object files found!'
	exit 2
fi



filenames=$(find $dirObjectFiles -maxdepth 1 -type f -name "*.o")
echo $logInfo 'found the following files for linking'
for value in $filenames
do
	echo '   ' $value
done

echo $logInfo 'linking files into executable named "result"'
ld -e _start -o result $filenames
status=$?
if [ $status -eq 0 ]
then
	echo $logInfo 'successfully created executable: ' $rootDir'/result'
else
	echo '####################################################'
	echo 'ERROR CREATING THE RESULTING FILE "result"'
	echo '####################################################'
	exit 2
fi
