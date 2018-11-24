#!/bin/bash
#pass rootDir as first parameter and object filenames to link as subsequent parameters

logInfo='test-link-all.sh :'
rootDir=$1

#-----------------------validation start---------------------
if [ -z $rootDir ]
then
	echo $logInfo ' you should enter rootDir followed by name of files to link'
	exit 2
fi

if [ ! -d $rootDir ]
then
	echo $logInfo $rootDir ' is not a directory!'
	exit 2
fi

inputArgs=($@)
numberOfArgs=${#inputArgs[@]}

if [ $numberOfArgs -eq 1 ]
then
	echo $logInfo ' you forgot to enter the name of files to link'
	exit 2
fi

#--------------------------end of validation------------------------

#check target folder for object and test-object files
cd $rootDir
dirObjectFiles=$(pwd)/target/object-files/
dirTestObjectFiles=$(pwd)/target/test-object-files/

if [ ! -d $dirObjectFiles ] || [ ! -d $dirTestObjectFiles ]
then
	echo $logInfo ' either ' $dirObjectFiles ' or ' $dirTestObjectFiles ' is not a directory!'
	exit 2
fi

#make temporary folder and copy all object files there
if [ -d tmp ]
then
	echo $logInfo 'removing already existing tmp directory'
	rm -r tmp
fi
mkdir tmp
tempDir=$(pwd)/tmp
find $dirObjectFiles -maxdepth 1 -type f -name '*.o' | xargs -I {} cp {} $tempDir
find $dirTestObjectFiles -maxdepth 1 -type f -name '*.o' | xargs -I {} cp {} $tempDir

#extract files to link from user input
filesToLink=()
#start at i=1 since first argument is the rootDirectory
echo $logInfo 'this are the files to link: '
for ((i=1;i<$numberOfArgs;i++))
do
	currentArg=${inputArgs[$i]}
	pathToFile=$tempDir/$currentArg
	filesToLink+=($pathToFile)
	echo '     '$pathToFile
done

echo $logInfo ' linking the following files:'
for value in ${filesToLink[@]}
do
	echo '     '$value
done

ld -e _startTest -o test-candidate ${filesToLink[@]}
status=$?
if [ $status -eq 0 ]
then
	echo $logInfo 'successfully create test file named "test-candidate"'
else
	echo '##############################################'
	echo $logInfo 'ERROR CREATING FILE "test-candidate"'
	echo '##############################################'
	exit 2
fi

rm -r $tempDir

