#!/bin/bash
# Copyright 2011, Falcon Technologies Corporation. All rights reserved
# Author: Paul Stusiak
#
# generate a file of all the retsid values

# is a value specified for the directory to search?

if [ $# -ne 1 ]; then
	echo 1>&2 'Usage: $0 <directory name>'
	exit 127
fi
echo '-- retsid checker --'
#echo 'running grep to pull out the retsid lines'
grep -rn '<retsid>' $@ > retsid-chk1.tmp
#echo 'running sed'
#echo 'cmd 1 - strip whitespace and DOS CR at end'
#echo 'cmd 2 - replace first instance of : with ,'
#echo 'cmd 3 - move the blocks of text around'
sed -e 's/.$//' -e 's/:/,/' -e 's/\(.*\):\(.*\)/\2 : \1/' retsid-chk1.tmp > retsid-chk4.tmp
#echo 'stripping whitespace at the start of line and writing output'
sed 's/^	*//' retsid-chk4.tmp > retsid-qa.out
#echo 'stripping retsid'
sed -e 's/<retsid>//' -e 's/<\/retsid>//' retsid-qa.out > retsid-chk6.tmp
#echo 'sorting'
sort -n retsid-chk6.tmp > retsid-sort.out
echo 'highest value retsid:'
sed '$!d' retsid-sort.out
#echo 'clean up'
rm retsid-chk1.tmp
rm retsid-chk4.tmp retsid-chk6.tmp
echo '-- done --'
