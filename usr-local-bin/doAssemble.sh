#!/bin/bash

logInfo='assemble.sh :'
fileToAssemble=$1

if [ -z $fileToAssemble ]
then
	echo $logInfo 'enter name of file to assemble'
else
	nasm -f elf -F stabs $fileToAssemble
fi
