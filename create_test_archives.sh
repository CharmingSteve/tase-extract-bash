#!/bin/bash

# Create test files with timestamps and varied/missing extensions

create_test_files() {
  mkdir -p test_files
  cd test_files

  for i in {1..8}; do
    timestamp=$(date +%Y-%m-%d_%H-%M-%S)
    echo "Hey! I was created at $timestamp" > file${i}.txt
  done

  # Create archives with varied extensions
  gzip file1.txt
  gzip file2.txt
  bzip2 file3.txt
  bzip2 file4.txt
  zip file5.txt file5.zip
  zip file6.txt file6.zip
  compress file7.txt
  compress file8.txt

  # Rename some files to have incorrect or missing extensions
  mv file1.txt.gz file1_no_ext
  mv file3.txt.bz2 file3.tar.z # Wrong extension
  mv file5.zip file5_wrong.txt # Wrong extension
  mv file7.txt.Z file7_no_ext

  mkdir -p gunzip_files bunzip2_files unzip_files compress_files
  mv file1_no_ext file2.txt.gz gunzip_files/
  mv file3.tar.z file4.txt.bz2 bunzip2_files/
  mv file5_wrong.txt file6.zip unzip_files/
  mv file7_no_ext file8.txt.Z compress_files/

  cd ..
}

create_test_files

