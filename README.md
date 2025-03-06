```markdown
# Universal Archive Extraction Script

A robust bash script that automatically detects and extracts various types of compressed files, handling multiple compression formats and recursive directory traversal.

## Features

- Automatically detects compression type using `file` command
- Supports multiple compression formats:
  - gzip
  - bzip2
  - zip
  - compress
- Recursive directory traversal
- Handles files regardless of extension
- Prevents duplicate processing of the same file
- Detailed debug output option
- Verbose operation mode
- Maintains original file permissions
- Overwrites existing files

## Requirements

The following utilities must be installed:
- `gzip/gunzip`: Typically pre-installed
- `bzip2/bunzip2`: Typically pre-installed
- `zip/unzip`: Install via `brew install zip unzip`
- `compress/uncompress`: Install via `brew install ncompress`
- `file`: Typically pre-installed

Install all requirements on macOS:
```bash
brew install gzip bzip2 zip unzip ncompress
```

## Usage

```bash
extract [-h] [-r] [-v] [-x] file [file...]
```

### Options

- `-h`: Show help message
- `-r`: Recursively process subdirectories
- `-v`: Verbose output
- `-x`: Enable debug output
- `--gunzip-opts`: Pass additional options to gunzip
- `--bunzip2-opts`: Pass additional options to bunzip2
- `--unzip-opts`: Pass additional options to unzip
- `--compress-opts`: Pass additional options to compress

### Examples

```bash
# Extract a single file
extract file.gz

# Extract multiple files
extract file1.gz file2.bz2 file3.zip

# Recursively extract all compressed files in a directory
extract -r directory/

# Verbose output with debug information
extract -vx file.gz

# Pass additional options to compression tools
extract --gunzip-opts="-f" file.gz
```

```markdown
### Testing

The repository includes a test file generator script:

```bash
# Create test files with various compression types
./create_test_archives.sh [-x]
```

This script creates a test environment with:
- Files compressed using all supported formats
- Files with incorrect/missing extensions
- Files in different subdirectories
- Duplicate files for testing recursive handling

The `-x` flag enables debug output to see exactly what files are being created.

Generated test structure:
```
test_files/
├── bunzip2_files/
│   ├── file3.tar.z    # bzip2 file with wrong extension
│   └── file4.txt.bz2
├── compress_files/
│   ├── file7_no_ext   # compress file without extension
│   └── file8.txt.Z
├── gunzip_files/
│   ├── file1_no_ext   # gzip file without extension
│   └── file2.txt.gz
└── unzip_files/
    ├── file5_wrong.txt  # zip file with wrong extension
    └── file6.zip
```

This test environment helps verify that the extract script correctly:
- Identifies compression types regardless of extension
- Handles missing/incorrect extensions
- Processes files recursively
- Prevents duplicate processing
```

## Features in Detail

- **Compression Detection**: Uses `file` command to detect compression type, ignoring file extensions
- **Recursive Processing**: Can traverse directories to find and extract all compressed files
- **Duplicate Prevention**: Uses inode tracking to prevent processing the same file multiple times
- **Status Reporting**: 
  - Reports number of successfully decompressed files
  - Reports number of files not decompressed
  - Provides detailed debug output with `-x` option
  - Verbose mode shows progress of each operation

## Exit Status

- Returns the number of files that were NOT decompressed
- Includes already decompressed files in the count
- Includes skipped directories when not in recursive mode

## Notes

- Files are decompressed in their original location
- Existing files are overwritten
- Already decompressed files are skipped and counted
- Original file permissions are preserved
```

