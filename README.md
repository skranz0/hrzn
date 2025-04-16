# HRZN 🌅

![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
[![Licence](https://img.shields.io/github/license/skranz0/hrzn?style=for-the-badge)](./LICENSE)

To release some pressure from the storage of our HPC Watson, we can put larger
files at an external storage past the *horizon* and retrieve them when needed.
To keep both connected, an `xlnk` exchange link file is created.

By only moving large files and keeping them linked, we can save a lot of space
and still keep project structure intact.

## Installation

To install HRZN download and unpack the latest [release](https://github.com/skranz0/hrzn/releases)
and run the `install` script:

```bash
sudo bash install
```

This will copy all neccessary files to the right locations in your system.
This includes a `config` at `/etc/hrzn/config` and a `hrzn` executable in `/usr/local/bin/`.

To use HRZN systemwide, you need to add it to your PATH.

## Usage

HRZN uses mainly three subcommands (partially still in developement):

- [x] `hrzn push` to push files to the external storage
- [x] `hrzn pull` to pull files from the external storage
- [ ] `hrzn check` to compare the checksum of the file in the external storage with
  the checksum safed in the link file
