#!usr/bin/bash
##################################################################################
# Perl command to extract particular records from an XML file without opening it
# Useful when the file size is in GB and it takes forever to open and fetch particular records
# Can be used directly at the command line 
# Here example InputFile.xml contains millions of records:
# <Main>
# <records>
# 	<record>
#   ........
#   </record>
#   <record>
#   ...
#   </record>
#   ...
#	<record>
#   </record>
#  </records>
# </Main>
###############################################################################################

perl -ne 'BEGIN{$/="</record>\n";}print m|(<record>.*040F14A.*S/)|ms' InputFile.xml > out.xml