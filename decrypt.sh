#!/usr/bin/env dash

cat ~/stow_files_compressed/pieces/peace* > ~/stow_files_compressed/compressed.tar.gz.gpg
rm -rf ~/stow_files_compressed/pieces
gpg --cipher-algo AES256 ~/stow_files_compressed/compressed.tar.gz.gpg

gpgconf --reload gpg-agent # to forget password

hash=$(sha256sum compressed.tar.gz)
hash2=$(cat ~/stow_files_compressed/hash)

if [ "$hash" != "$hash2" ]
then
    echo "some corruption occured"
    exit 1
fi

mkdir ~/stow_files_compressed/uncompressed
tar -zxvf ~/stow_files_compressed/compressed.tar.gz -C ~/stow_files_compressed/uncompressed/

rm -rf ~/stow_files_compressed/compressed.tar.gz
rm -rf ~/stow_files_compressed/compressed.tar.gz.gpg
rm -rf ~/stow_files_compressed/hash