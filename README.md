# git-scripts

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![GitHub all releases](https://img.shields.io/github/downloads/rgglez/git-scripts/total)
![GitHub issues](https://img.shields.io/github/issues/rgglez/git-scripts)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/rgglez/git-scripts)
[![Go Report Card](https://goreportcard.com/badge/github.com/rgglez/git-scripts)](https://goreportcard.com/report/github.com/rgglez/git-scripts)
[![GitHub release](https://img.shields.io/github/release/rgglez/git-scripts.svg)](https://github.com/rgglez/git-scripts/releases/)

Misc utils for GIT.

## check_repos.pl

Perl script to check a directory full of GIT repositories to find out which ones have pending commits.

### Options

* ```-u``` Use this flag to mass-update the repositories.

### Dependencies

* ```git``` command line.
* **Cwd** perl module.
* **Getopt::Long** perl module.

