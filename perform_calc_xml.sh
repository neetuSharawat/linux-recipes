#!usr/bin/env bash
##################################################################################################
# Script showcasing usage of awk, grep, for loop to perform various calculations on multiple files

##################################################################################################

LOB=$1
CLIENT_audit_file=$2
IPSUM_file=$3
xmlfile=$4
DB_output=$5

echo > file.txt

totalStmtHost_calc=`cat $CLIENT_audit_file | wc -l`

totalIntParty_calc=`awk -F"," '{x+=$2}END{print x}' $IPSUM_file`

totalHouseHold_calc=`grep -e '<ClientInterestedParty>Client' -A 125 $xmlfile | grep -e '<HouseholdIndicator>Y' |wc -l`

totalPullStmt_calc=`grep -e '<ClientInterestedParty>Client' -B 30 $xmlfile | grep -e '<Queue>PL' | wc -l`

totalStmts_calc=`grep -e '<ClientInterestedParty>Client' $xmlfile | wc -l`

totalPrintSuppressedStmts_calc=`grep -e '<ClientInterestedParty>Client' -B 30 $xmlfile | grep -e '<PrintInd>N' -A 4 | grep -e '<electronic>Y' -A 2 | wc -l`

count=0

for i in `ls *CLIENT-$LOB-*`
do
	((count++))
	grep -e '*XDFN NAME' $i | wc -l >> file.txt
done

value=`awk '{x+=$1}END{print x}' file.txt`
totalEmailStmt_calc=`expr $value - $count \* 2`

echo > calc.csv
echo "Values calculated from XML and Audit files for $LOB are: " >> calc.csv
echo "totalStmtHost_calc: " $totalStmtHost_calc >> calc.csv
echo "totalIntParty_calc: " $totalIntParty_calc >> calc.csv
echo "totalHouseHold_calc: " $totalHouseHold_calc >> calc.csv
echo "totalPullStmt_calc: " $totalPullStmt_calc >> calc.csv
echo "totalStmts_calc: " $totalStmts_calc >> calc.csv
echo "totalPrintSuppressedStmts_calc: " $totalPrintSuppressedStmts_calc >> calc.csv
