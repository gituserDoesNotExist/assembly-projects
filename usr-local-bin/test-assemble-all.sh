#!/bin/bash
#pass location of rootDir. 
#first in assembles files in rootDir/src/main.
#Then it searches in rootDir/src/test for ASM files. After assembling they are copied to rootDir/target/test-object-files

logInfo='test-assemble-all.sh :'
rootDir=$1

if [ -z $rootDir ]
then
	echo $logInfo 'you forgot to enter the root directory!'
	exit 2
fi

if [ ! -d $rootDir ]
then
	echo $logInfo $rootDir 'is not a valid directory!'
	exit 2
fi

/usr/local/bin/assemble-all.sh $rootDir
status=$?
if [ $status -ne 0 ]
then
	echo '#########################################################'
	echo $logInfo 'ERROR DURING ASSEMBLING SOURCE FILES FROM MAIN'
	echo '########################################################'
	exit 2
fi
#assembling test files
cd $rootDir
dirTestSourceFiles=$(pwd)/src/test/
dirTestTargetFiles=$(pwd)/target/test-object-files/

if [ ! -d $dirTestSourceFiles ] || [ ! -d $dirTestTargetFiles ]
then
	echo $logInfo 'either' $dirTestSourceFiles ' or ' $dirTestTargetFiles ' does not exist!'
	exit 2
fi

filesToAssemble=$(find $dirTestSourceFiles -type f -name '*.asm')

echo $logInfo 'Assembling the following files: '
for value in $filesToAssemble
do
	echo '     '$value
	nasm -f elf -F stabs $value
	status=$?
	if [ ! $status -eq 0 ]
	then
		echo '##########################################'
		echo $logInfo 'ERRO DURING ASSEMBLING FILE '$value
		echo '##########################################'
		exit 2
	fi
done

objectFiles=$(find $dirTestSourceFiles -type f -name '*.o')

echo $logInfo 'moving the following files: '
for value in $objectFiles
do
	valueToPrint=$(echo $value | sed "s~$rootDir~rootDir~g")
	dirTargetTestFilesToPrint=$(echo $dirTestTargetFiles | sed "s~$rootDir~rootDir~g")
	echo '    move' $valueToPrint 'to' $dirTargetTestFilesToPrint
	mv $value $dirTestTargetFiles
done



