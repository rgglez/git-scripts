#!/usr/bin/perl

use strict;
use warnings;
use Cwd;
use Getopt::Long;

###############################################################################
#    Checks if a set of git repositories have uncommited changes, and 
#    optionally update them.
#
#    Copyright 2024 Rodolfo González González
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
###############################################################################

# Parse command-line options
my $update_flag;
GetOptions('u' => \$update_flag);

# Get the current directory
my $current_dir = getcwd();

# Open the current directory and read its contents
opendir(my $dh, $current_dir) or die "Cannot open directory: $!";
my @subdirs = grep { -d $_ && !/^\.+$/ } readdir($dh);
closedir($dh);

# Array to store directories with pending changes
my @pending_changes;

foreach my $subdir (@subdirs) {
    # Skip if it's not a git repository
    next unless -d "$subdir/.git";

    print "Entering directory: $subdir\n";

    # Change to the subdirectory
    chdir $subdir or die "Cannot change to directory $subdir: $!";

    # Check the git status
    my $status = `git status --porcelain`;
    if ($status) {
        print "Changes to commit in $subdir:\n$status\n";
        push @pending_changes, $subdir;
    } else {
        print "Nothing to commit in $subdir.\n";
        # Pull from the remote repository if the -u flag is set
        if ($update_flag) {
            print "Pulling updates from the remote repository for $subdir...\n";
            my $pull_output = `git pull 2>&1`;
            print "$pull_output\n";
        }
    }

    # Return to the parent directory
    chdir $current_dir or die "Cannot return to $current_dir: $!";
}

# Print summary
if (@pending_changes) {
    print "\nSummary:\n";
    print "The following directories have pending changes to commit:\n";
    print " - $_\n" for @pending_changes;
} else {
    print "\nSummary:\nNo directories have pending changes to commit.\n";
}
