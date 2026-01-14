# My Cat Utility

Custom implementation of the `cat` command-line utility for displaying text files.

## Features
- **File display**: output file contents to `stdout`
- **Supported Flags**:
  - `-b`, `--number-nonblank`: Number non-empty lines
  - `-e`: The same as `-v` and `-E` together
  - `-E`: Display `$` at end of lines (`^M$` for Windows files)
  - `-n`, `--number`: Number all lines
  - `-s`, `squeeze-blank`: Squeeze multiple blank lines into one
  - `-t`: Display non-printable characters (except for newlines)
  - `-T`: Display tab characters as `^I`
  - `-v`: Display non-printable characters (except for tabs and newlines)
- **Compatible with POSIX `cat`**

## Build

```bash
make                 # Build the executable (creates 'my_cat')
make all             # Same as 'make'
make clean           # Remove built executable
make rebuild         # Clean and rebuild
make test            # Run automated tests
```

## Usage
```bash
./my_cat [flag] [files...]
./my_cat -n file.txt
./my_cat -e file1.txt file2.txt
```
