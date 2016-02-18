#!/bin/bash -f
version=0.0
## usage : ./do_it.sh design.txt *.fastq.gz

d=`date`
echo "## script do_it.sh running in version $version"
echo "## date is $d"
design=$1;
shift;

echo -n "Sample"
while read line
do
    mut=`echo $line | sed -e s/=\.\*//g`
    echo -n " $mut";
done < $design
echo ""


for file in $*
do

    echo -n $file
    total=0

    while read line  
    do  
	Forward=`echo $line | sed -e s/\.\*=//g`
	Reversed=`echo $Forward | rev`
	Reversed=`echo $Reversed | tr A W | tr C X | tr G Y | tr T Z`
	Reversed=`echo $Reversed | sed -e s/\(/V+/g | sed -e s/\+\)/S/g`
	Reversed=`echo $Reversed | tr W T | tr X G | tr Y C | tr Z A | tr V ")" | tr S "("`
	nb=$(grep -c -E "${Forward}"\|"${Reversed}" $file)
	echo -n " $nb"
    done < $design

    echo ""

done
