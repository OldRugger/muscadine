# muscadine
GAOC Southeast Interscholastic Scoring System V3

## GAOC SEIS Scoring System

This application is the Georgia Orienteering Club's implementation of the Average Weighted Time (AWT) team scoring system used for the Southeast Interscholastic Championships.  The system is based on the interscholastic scoring rules published by Orienteering USA.  It is also based, in part, on a spreadsheet developed by the North Texas Orienteering Associatation that server the same perpose.  The system uses input files from Sports Software OE system. 

{Sample results file}[http://htmlpreview.github.io/?https://github.com/OldRugger/seis_2/blob/master/testdata/test_results.html]

### Scoring Rules

#### AWT 
(Class AWT) used within the Team score calculation for successful runners

#### CAT AWT 
(Category AWT) used within the Team score calculation for DNF, MP, Disq runners

#### Scoring
Scores for each race are computed as follows:
1. For each interscholastic class, define AWT (the average winning time) as the average of the times of the top three competitors in that class who are competing in a team category.
1. For each competitor in each class with a valid result, their score is computed as 60*(competitor’s time)/ (AWT for the class).
1. For competitors with an OT, MP, DNF or DSQ result, their score will be the larger of 10+60*(course time limit)/ (AWT for the male class) and 10+60*(course time limit)/ (AWT for the female class) for that team category.
#### Team Scoring 
1. The best three scores each day for each team are combined for a team score.
1. Lowest overall team score wins.

### Input Files
#### =Initial Load File 
* OE013 
#### Team Definition 
* CSV file with the following columns: Database ID,Team,Class,JROTC,Branch,School
  * 'Database ID' is the OE Database ID. This field is used to tie everything together.  This field must be defined in OE. 
  * Team name - team names should be unique
  * Class - ISV, ISJV, ISI, ISP 
  * JROTC - yes/no
  * Branch - if JROTC
  * School 
The file should be sorted by 'Team', 'Class'
#### Results
* OE0010 - two day results. 
#### Sample data
Examples of all three files can be found in the testdata directory

### Processing
#### Import Runners \ Teams
* From the main page, select "Import Runners / Teams"
* From the Runners page select the Import Runners file (OE0013), then select Import_Runners.  
* Import teams, select the csv team definition file, then select Import_Teams.
#### Processing results. 
* Copy the results file (OE0010) in the the results directory (configurable).  The file will be auto detected and processed.  Caution, the file will be deleted at the end of processing. 

### Output Pages (may change)
#### Runners 
This page has a detail listing of all runners imported into they system
#### Teams 
Current team results
#### Team2
More detailed team results.  All styling is included in the file.  The page source can be copied without loss of formatting.  
#### AWT
Detailed information on the Average Weighted Time calculation 


