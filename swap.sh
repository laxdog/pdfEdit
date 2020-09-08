#!/bin/bash

INFILE=$1
INNBR=$2
OUTNBR=$3

function usage {
    echo "You much supply the input file, number to change and the number to change to. Like so:"
    echo "swap.sh Bill.pdf 07987654321 07123456789"
}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    usage
    exit 1
fi

split2a="$(echo $2 | cut -c 1-5)"
split2b="$(echo $2 | cut -c 6-)"
split3a="$(echo $3 | cut -c 1-5)"
split3b="$(echo $3 | cut -c 6-)"
echo will test for :
echo $2
echo $split2a $split2b

echo "Using file $1, changing $2 to $3"
qpdf --qdf --object-streams=disable $1 expanded.pdf

strings expanded.pdf | grep $2 
sed -i s/$2/$3/g expanded.pdf 

strings expanded.pdf | grep $split2a | grep $split2b
sed -i s/$split2a/$split3a/g expanded.pdf
sed -i s/$split2b/$split3b/g expanded.pdf
mv $1 $1_orig
qpdf expanded.pdf $1_hacked
qpdf expanded.pdf $1
