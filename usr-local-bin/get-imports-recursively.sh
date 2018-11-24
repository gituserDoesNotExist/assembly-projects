#!/bin/bash

logInfo='get-imports-recursively.sh: '
resultingFilenames=()
statusString=''
counter=0

function containsElement {
	local needleInput=$1
	local needle=${needleInput%%.*}
	local haystack="${@:2}"
	for valueInHaystack in ${haystack[@]}
	do
		nameToTest=${valueInHaystack%%.*}
		if [ $nameToTest = $needle ]
		then
			return 0
		fi
	done
	return 1
}

function getAllFilenames {
	#declare local variables
	local filepath=''
	local currentFileName=$1

	#status string
	counter=$(($counter+1))
	statusString=$statusString'-'
#	echo $statusString$counter 'current file ' $currentFileName
	
	#check if parameter has been passed
	if [ -z $currentFileName ]
	then
		return 0
	fi
	#check if passed file exists
#	echo 'checking'
	if [ ! -f $currentFileName ]
	then
		echo '##################################################'
		echo $logInfo $currentFileName 'could not be found!'
		echo '##################################################'
		exit 2
	fi
	#end check########
#	echo 'end checking'
	#search for files
	filenamesFoundInFile=$(/usr/local/bin/get-imports.sh $currentFileName)
#	echo 'filenames found in file ' ${filenamesFoundInFile[@]}	
#	echo 'start loop'
	for value in $filenamesFoundInFile
	do
#		echo 'in loop'
		filepath=$(find $rootDirSourceFiles -type f -name $value'.asm')
		filenameWithExtension=$value'.o'
		containsElement $filenameWithExtension ${resultingFilenames[@]}
		status=$?
		if [ $status -ne 0 ]
		then
			resultingFilenames+=($filenameWithExtension)
		fi
		getAllFilenames $filepath	
	done
#	echo 'end loop'
	#status string
#	echo $statusString$counter
	counter=$(($counter-1))
	statusString=${statusString:0:counter}

}

rootDirSourceFiles=$1
fileToSearch=$2

if [ -z $rootDirSourceFiles ] || [ ! -d $rootDirSourceFiles ]
then
	echo $logInfo 'invalid rootDir: ' $rootDirSourceFiles
	exit 2
fi

if [ -z $fileToSearch ]
then
	echo $logInfo 'enter name of starting file!'
	exit 2
fi

objectFileOfFileToSearch=$(echo $fileToSearch | sed 's/.asm/.o/g')
resultingFilenames+=($objectFileOfFileToSearch)
getAllFilenames $fileToSearch


#finalResult=$(echo ${resultingFilenames[@]} | tr ' ' '\n' | sort -u | tr '\n' ' ')
#echo ${finalResult[@]}

echo ${resultingFilenames[@]}



