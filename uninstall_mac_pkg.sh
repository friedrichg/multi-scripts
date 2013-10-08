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
if [[ $# -lt 1 ]]
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
 info="$(pkgutil --info $1)"
 echo "$info"
 echo "$info" >> $LOG
 location="/$(echo "$info"|grep location|cut -c11-)"
 echo "WARNING:: the location to remove files is: $location"
 echo "The files removed will be archived at /tmp/$1.tar"
fi

#Confirm UNINSTALLATION
function confirm(){
	echo -n "Proceed with this? [a/y/N]:"
	read ans
        if [[ $ans == 'a' ]]; then
           echo "Uninstalling all"
           return 1
        elif [[ $ans == 'y' || $ans == 'Y' ]]
	then
	 echo "Uninstalling $1"
           return 0
	else
	 echo "Uninstallation aborted!"
	 exit 0;
	fi
}

confirm

#Do it from root
cd "$location"

#Generating the list of files
FILES=$(pkgutil --only-files --files $1)
echo $FILES >> $LOG

#Generating the list of directories
DIRS=$(pkgutil --only-dirs --files $1)
echo $DIRS >> $LOG

#Archive  all the files
echo "Creating archive at /tmp/$1.tar ..."
echo "$FILES"| tar -cf /tmp/$1.tar -T -

echo "This files are in backup:"
tar -tvf /tmp/$1.tar
all=0
echo "Deleting files ..."
IFS=$'\n'
for file in $FILES
do
 #pkgutil --file-info "$file"
 #pkgid="$(pkgutil --file-info "$file"|grep pkgid)"
 #echo "pkgid=$pkgid"
 if [[ $(pkgutil --file-info "$file" | grep pkgid | wc -l) -ne 1 ]]
 then
  echo "$file is used by another package and not removing!"
 else
  echo rm -vf "$file"
  if [[ "$all" -eq 0 ]]; then
     confirm
     all=$?
  fi
  rm -vf "$file" 1>$LOG 2>&1
 fi
done
all=0
echo "Deleting dirs ..."
for dir in $DIRS
do
 if [[ $(pkgutil --file-info $dir | grep pkgid | wc -l) -ne 1 ]]
 then
  echo "$dir is used by another package and mot removing!"
 else
  echo rm -vfr "$dir"
  if [[ "$all" -eq 0 ]]; then
     confirm
     all=$?
  fi
  rm -vfr "$dir" 1>$LOG 2>&1
 fi
done

#Forgetting the package from pkg database
echo "Forgetting the package $1..."
echo pkgutil --forget $1
