#!/bin/bash
# taken from http://nmlaxaman.blogspot.com.es/2013/02/clean-uninstaller-for-mac-os-x.html
# Copyright (C) 2008 Nayanajit Mahendra Laxaman mail: nmlaxaman@gmail.com

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
LOG=/var/log/uninstall.log

#Verify the arguments
if [[ $# -ne 1 ]]
then
 echo "Usage:"
 echo "$0 "
 echo "NOTE:The PKGID should be as in 'pkgutil --pkgs' list."
 echo "Eg:"
 echo "$0 com.apple.pkg.JavaForMacOSX107"
 exit 1
fi

if [[ $UID -ne 0 ]]; then
   echo "you are not root!"
   exit 2
fi

#Check the availability of the package
if [[ $( pkgutil --pkgs | grep "$1" ) == ''  ]]
then
 echo "Package $1 not installed!"
 exit 1
else
 echo "Following package will be uninstalled:"
 pkgutil --info $1
 sudo pkgutil --info $1 >> $LOG
 echo "The files removed will be archived at /tmp/$1.tar"
fi

#Confirm UNINSTALLTION
echo -n "Proceed with UNINSTALLTION [y/N]:"
read ans
if [[ $ans == 'y' || $ans == 'Y' ]]
then
 echo "Uninstalling $1"
else
 echo "Uninstalltion aborted!"
 exit 0;
fi

#Do it from root
cd /

#Generating the list of files
FILES=$(pkgutil --only-files --files $1 | tr '\n' ' ' )
sudo echo $FILES >> $LOG

#Generating the list of directories
DIRS=$(pkgutil --only-dirs --files $1 | tr '\n' ' ')
sudo echo $DIRS >> $LOG

#Archive  all the files
echo "Creating archive at /tmp/$1.tar ..."
tar -cf /tmp/$1.tar  $FILES

echo "Deleting files ..."
for file in $FILES
do
 if [[ $(pkgutil --file-info $file | grep pkgid | wc -l) -ne 1 ]]
 then
  echo "$file is used by another package and not removing!"
 else
  sudo rm -f $file
 fi
done

echo "Deleting dirs ..."
for dir in $DIRS
do
 if [[ $(pkgutil --file-info $dir | grep pkgid | wc -l) -ne 1 ]]
 then
  echo "$dir is used by another package and mot removing!"
 else
  sudo rm -fr $dir
 fi
done

#Forgetting the package from pkg database
echo "Forgetting the package $1..."
sudo pkgutil --forget $1
