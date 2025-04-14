# HRZN 🌅

To release some pressure from the storage of our HPC Watson, we can put larger
files at an external storage past the *horizon* and retrieve them when needed.
To keep both connected, an `xlnk` exchange link file is created.

By only moving large files and keeping them linked, we can save a lot of space
and still keep project structure intact.

## Usage

HRZN uses mainly three subcommands (partially still in developement):

- [x] `hrzn push` to push files to the external storage
- [ ] `hrzn pull` to pull files from the external storage
- [ ] `hrzn check` to compare the checksum of the file in the external storage with
  the checksome safed in the link file
