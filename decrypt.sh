#!/usr/bin/bash

echo first param following encrypt.sh specify what \*.gpg file to decrypt

# request encrypted filename if not provided as parameter and Exit with error
if [[ -z ${1} ]]; then echo "input encrypted filename as first parameter" && exit 1; else echo "your file is being decrypted"; fi

archive_file_name=${1%.gpg}

# decrypt file to compressed archive
gpg --output "$archive_file_name" --decrypt "${1}"

# decompress archive to original folder
tar xzvf "${archive_file_name}"

# remove compressed archive
rm "${archive_file_name}"
