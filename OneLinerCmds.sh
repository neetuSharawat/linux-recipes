#################################################################################
# Examples of one line commands in Linux, useful when the user doesn't have the 
# rights to execute the script file.
# loop on single command line
# awk examples
#################################################################################

# Find status of oozie jobs in Hadoop

for i in `oozie jobs -oozie http://server:11000/oozie -jobtype coordinator -filter status=RUNNING| grep IDENTIFIER | awk -F " " '{print $1}; do echo $i'; oozie job -oozie http://server:11000/oozie -info $i -verbose; done > job_status.txt

#Sum total of second column, group by first column
awk -F, '{a[$3]+=$4;}END{for(i in a)print i", "a[i];}' input_file 

#unique column
awk -F, '{a[$1];}END{for (i in a)print i;}' input_file

awk -F "," '{ if ($6 > 0) $4=$4*$6; print $0}' my_file.csv

awk -F "," '{if ($1 >= '20170601' && $1 <= '20170630') print $0}' my_file.csv

awk -F, 'FNR==NR {a[$1]=$0;next}; $1 in a {print a[$1]}' file2 file1

for i in `cat my_file.csv`; do grep -q -e $i read_file.csv;if [ $? -ne 0 ]; then echo $i >> not_found.txt;continue; else echo $i >> found_text.txt;fi;done

sort -k 1 my_list.txt > sorted_list.txt

cat my_file.csv | awk -F "," '{if ($1 >=20170601 && $1 <= 20170630) a[$2]+=$3}END{for (i in a) print i,a[i]}' > output.csv


