#!/usr/bin/env bash
#####################################################################
#    Create soft links for files from source to target directory    #
#####################################################################

# usage:
# > link_files.sh SOURCE_DIR TARGET_DIR
# example: link_files.sh /mnt/store/source_dir /home/shar/target_dir

Source=`readlink -f $1`
Target=`readlink -f $2`

cd $Source

echo "source is: " $Source

Files=`stat -c "%F %n" * | grep "regular file" | cut -d'' -f 3-`

for i in Files
do
	echo $i
	ln -s ${Source}/$i ${Target}
done

echo "The linked files under the target directory are:"
ls -lrt ${Target}/

