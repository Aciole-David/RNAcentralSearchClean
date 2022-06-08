# RNAcentralSearchClean
Format and beautify RNAcentral's nHMMer output

https://github.com/Aciole-David

>Backup your inputs before running
>>Suggestion: Rename each zip to the respective query file name before running

RNAcentral sequence search output is kinda confuse to analyse.

The downloadable output is a randomly named zip file like this:

- f76fcc47-50ff-4a15-9bde-5b2d9781b434.zip
   - datapackage.json
     - sequences(folder)
      - similar-sequences.json
      - similar-sequences.txt

The similar-sequences.txt file contains the similarity data (subject, E-value, identity, coverage, gaps) along with each alignment.

This script gets one or several ziped RNAcentral nhmmer outputs
and extract all metrics in a simples tabular file
So users can see the results easier, apply filter, plot, etc.


