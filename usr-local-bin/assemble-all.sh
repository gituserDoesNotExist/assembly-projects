#!/bin/bash

#pass the root directory as parameter. From there it will search in rootDir/src/main for ASM files
#the object files will be copied to rootDir/target/object-files
logInfo='assemble-all.sh :'
rootDir=$1

if [ -z $rootDir ]
then
	echo $logInfo 'you should pass the location of the rootDirectory of your project'
	exit 2
fi

if [ ! -d $dir ]
then
	echo $logInfo $dir 'is not a valid directoy'
	exit 2
fi

cd $rootDir
dirSourceFiles=$(pwd)/src/main
dirTargetFiles=$(pwd)/target/object-files

if [ ! -d $dirSourceFiles ] || [ ! -d $dirTargetFiles ]
then
	echo $logInfo 'either ' $dirSourceFiles ' or ' $dirTargetFiles ' does not exist!'
	exit 2
fi	


echo $logInfo 'cleaning target folder: ' $dirObjectFiles
filesToDelete=$(find $dirObjectFiles -maxdepth 1 -type f -name "*.o")
if [ -z $filesToDelete ]
then
	echo $logInfo 'folder already empty'
else
	echo $logInfo 'deleting:'
	for value in $filesToDelete
	do
		echo '    '$value
		rm $value
	done
fi
status=$?
if [ $status -ne 0 ]
then
	echo $logInfo 'could not clean ' $dirObjectFiles
	exit 2
fi

echo $logInfo 'searching for files in ' $dirSourceFiles

filesToAssemble=$(find $dirSourceFiles -type f -name '*.asm')

echo $logInfo 'found the following files for assembling: '
for value in $filesToAssemble
do
	echo '     '$value
	doAssemble.sh $value
	status=$?
	if [ $status -ne 0 ]
	then
		echo '##################################################'
		echo $logInfo 'ERROR DURING ASSEMBLING FILE '$value
		echo '##################################################'
		exit 2
	fi
done

objectFiles=$(find $dirSourceFiles -type f -name '*.o')

echo $logInfo 'moving files within rootDir='$rootDir
for value in $objectFiles
do
	valueToPrint=$(echo $value | sed "s~$rootDir~rootDir~g")
	dirTargetFilesToPrint=$(echo $dirTargetFiles | sed "s~$rootDir~rootDir~g")
	echo '    move '$valueToPrint 'to' $dirTargetFilesToPrint
	mv $value $dirTargetFiles
done

