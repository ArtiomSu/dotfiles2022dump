#!/usr/bin/env dash
rm -rf ~/stow_files_compressed/compressed.tar.gz

tar -zcvf ~/stow_files_compressed/compressed.tar.gz ~/stow_files

sha256sum compressed.tar.gz > hash

gpg -c --cipher-algo AES256 ~/stow_files_compressed/compressed.tar.gz

gpgconf --reload gpg-agent # to forget password

rm -rf ~/stow_files_compressed/compressed.tar.gz
rm -rf ~/stow_files_compressed/uncompressed

#next split files
rm -rf ~/stow_files_compressed/pieces
mkdir ~/stow_files_compressed/pieces
split --bytes=90M ~/stow_files_compressed/compressed.tar.gz.gpg ~/stow_files_compressed/pieces/peace
rm -rf ~/stow_files_compressed/compressed.tar.gz.gpg
