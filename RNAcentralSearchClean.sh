#!/bin/bash

#https://github.com/Aciole-David

##################################
#Format RNAcentral's nHMMer output 
##################################

#BACKUP ALL YOUR INPUTS BEFORE RUNNING THIS!!!

#Rename each zip to the respective query file name before running this script

# 1 - remove all characters after space in filenames
#obs: optional if filenames are too long, have spaces/unnecessary/weird characters, etc
echo -e "\n Removing spaces and everything after it from filenames"
find -name "* *" -type f | rename 's/ .*\././g'

# 2 - Uncompress each zip with unar
echo -e "\n Uncompressing inputs"
for file in *.zip; do unar $file; done

# 3 - rename txt files based on parent folder name
#RNAcentral stores the outputs in ziped files that have the same name for every query
#obs:  necessary if need to merge the output from several queries
echo -e "\n Renaming \"similar-sequences.txt\" to the query filename"
shopt -s globstar  # makes '**' match any parent folder levels
rename 's:/:-:g' **/*.txt

# 4 - remove all characters after space in filenames
#obs: optional if filenames are too long, and have unnecessary/weird characters
echo -e "\n Removing unnecessary text from filenames"
find -name "*-sequences-similar-sequences*" -type f | rename 's/-sequences-similar-sequences.txt/.temptxt/g'

#-----------------

#1: insert filename before subject name
#2: remove new line before E-value so it goes up after subject name
#3: get only the lines containing output metrics
#4: append in new "temp_[input name]" file
#obs: the  fields are separated by tab character ("\t") so we have a simple table in the end
echo -e "\n Joining query names to the lines containing the data subject and similarity metrics"
for file in *.temptxt; do 
sed -ze "s,>> ,$file\t,g
s,\nE-value,\tE-value,g" $file| grep 'E-value'>temp_${file}; done

#----------------

#1: remove the metrics' names before their respective values
#2: add their names as the first line, tab-separated again
#3: append output to a tidy_[input name] file.
echo -e "\n Removing metrics names from each line"
for file in temp_*;
do
sed -ze "s,E-value: ,,g
s,Identity: ,,g
s,Query coverage: ,,g
s,Gaps: ,,g" $file>temp2_${file}; done

#----------------

#1: merging the outputs
#2: adding collumn names header at top
#3: removing dummy extension ".temptxt" from the query names
echo -e "\n Merging outputs"
cat temp2*> merged_results.tabular
sed -i '1 i\Query\tSubject\tE-value\tIdentity\tQuery coverage\tGaps' merged_results.tabular
sed -i 's/.temptxt//g' merged_results.tabular

#delete temp files
rm *.temptxt

echo -e "\n Finished!"
