# encrypted-backups
Simply encrypts and decrypts the content of a directory

## use case

As a backup strategy, you may want to use public cloud storage. But you don't want to provide them with the content of your valuable data. So, before sending files to the cloud make sure you encrypt them yourself.

These scripts use `GPG - The GNU Privacy Guard`, a proven open-source library that makes easy to encrypt your data.

note: our scripts never handle your passphrase nor store it. Instead, we let GPG prompt your for these informations. Kindly inspect our code to get convinced of this.

## Encrypting a directory and all its files

1- make `encrypt.sh` script executable:
```
chmod +x encrypt.sh
```
2- run script and provide name of directory to be encrypted and name of the encrypted file you want to generate:
```
./encrypt myDirectoryName myEncryptedFileName
```

3- a prompt will ask you for a passphrase. Make sure to write it down in order to be able to decrypt your file later.

## Decrypting a directory
1- make `decrypt.sh` script executable:
```
chmod +x encrypt.sh
```
2- run script and provide name of encrypted file that needs to be decrypted:
```
./decrypt myEncryptedFile.tar.gz.gpg
```

3- a prompt will ask you for the passphrase used to encrypt the file. If someone else had previously encrypted the file, kindly ask this person to provide your with it.