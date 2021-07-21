#!/usr/bin/bash

echo first param following encrypt.sh sets path to encrypted folder ...defaults to a directory named FILES
echo second param sets encrypted filename ...defaults to ARCHIVE

# argument 1 - set path to encrypted folder (defaults to /files/)
if [ -z ${1+x} ]; then dir_path="files"; else dir_path=$1; fi

# argument 2 - set archive name (defaults to 'archive')
if [ -z ${2+x} ]; then archive="archive"; else archive=$2; fi

# compress given directory to a custom named archive
archive_filename=${archive}-$(date +"%Y-%m-%d").tar.gz
tar -zcvf ${archive_filename} ${dir_path}/*

# encrypt archived file
gpg --output ${archive_filename}.gpg --symmetric $archive_filename

# remove temporary compressed directory
rm ${archive_filename}
