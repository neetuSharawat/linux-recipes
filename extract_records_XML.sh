#!usr/bin/env bash
##################################################################################
# Script to extract particular records from an XML file without opening it
# Useful when the file size is in GB and it takes forever to open and fetch particular records
# Here example InputFile.xml contains millions of records:
# <Main>
# <records>
# 	<stateID>
#   <record>
#   ...
#	</record>
#   </stateID>
#   <stateID>
#   <record>
#   ...
#	</record>
#   </stateID>
#   ...
#	<stateID>
#   <record>
#   ...
#	</record>
#   </stateID>
#  </records>
# </Main>
###############################################################################################

LOB=$1
xmlfile=$2
list=$3

# list of records to search and extract from the large XML file
RECORDS=(07F8 06J8 09R8 10Q7 608G 767D 20J7)

ARR=RECORDS[@]

echo "start time: " `date`

for recordId in ${!ARR}
do
	grep -q -e $recordId $xmlfile
	if [ $? -ne 0 ]
	then
		echo $recordId >> notfound.txt #save the recordIds which are not found in the input file
		continue
	else
		grep -F "<stateID>$recordID</stateID>" -B 52 -A 10000 $xmlfile| perl -ne 'BEGIN{$/="</record>\n";}print m|(<record>.*'$recordId'.*$/)|ms' >> out.xml #extract the record details and append to out.xml
	fi
done

sed -n '/<\?xml/,/<records>/p' $xmlfile > header.txt #extract header to save into header.txt
tail -n 15 $xmlfile | sed -n '/<\/records>/,/<\/root>/p' > footer.txt # extract footer info to footer.txt

cat header.txt out.xml footer.txt > MyFile.xml #create the xml file containing the found records
rm -rf out.xml header.txt footer.txt

echo "end time: " `date`