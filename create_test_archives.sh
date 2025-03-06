#!/bin/bash

# Create test files with timestamps and varied/missing extensions

# Usage: create_test_archives.sh [-x]
#   -x: Enable debug mode (print commands before execution)

DEBUG=true

# Function to print commands if debug mode is enabled
debug() {
  if $DEBUG; then
    echo "+ $@"
  fi
  "$@"
}

# Parse command-line arguments
while getopts "x" opt; do
  case $opt in
    x)
      DEBUG=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND - 1))

create_test_files() {
  debug mkdir -p test_files
  debug cd test_files

  for i in {1..8}; do
    timestamp=$(date +%Y-%m-%d_%H-%M-%S)
    debug echo "Hey! I was created at $timestamp" > file${i}.txt
  done

  # Create archives with varied extensions
  debug gzip file1.txt
  debug gzip file2.txt
  debug bzip2 file3.txt
  debug bzip2 file4.txt
  debug zip file5.zip file5.txt # Add file5.txt to the archive
  debug zip file6.zip file6.txt # Add file6.txt to the archive
  # Check if compress is installed
  if command -v compress &> /dev/null
  then
      debug compress file7.txt
      debug compress file8.txt
  else
      echo "Warning: compress command not found. Skipping compression for file7.txt and file8.txt"
      touch file7.txt.Z file8.txt.Z
  fi

  # Rename some files to have incorrect or missing extensions
  debug mv file1.txt.gz file1_no_ext
  debug mv file3.txt.bz2 file3.tar.z # Wrong extension
  debug mv file5.zip file5_wrong.txt # Wrong extension
  debug mv file7.txt.Z file7_no_ext

  debug mkdir -p gunzip_files bunzip2_files unzip_files compress_files
  debug mv file1_no_ext file2.txt.gz gunzip_files/
  debug mv file3.tar.z file4.txt.bz2 bunzip2_files/
  debug mv file5_wrong.txt file6.zip unzip_files/
  debug mv file7_no_ext file8.txt.Z compress_files/

  debug cd ..
}

create_test_files
