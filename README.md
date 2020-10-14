# Merck R&D | Global Epidemiology
## Code List Builder
-------------

### Change Log
06/27/2018 - Converted all data files to use Feather format for better efficiency and added options to use 2- and 4- digit search on ICD-9 and ICD-10 codes. Also separated the ICD-9 and ICD-10 boxes from each other in the menu. Finally, added a message to show that the code list builder is live for funsies!

10/14/2020 - Added MedDRA mapping file from Medical Coding.
10/14/2020 - Added experimental action button to add classifier variable and reset selections.
10/14/2020 - Added information tab item to provide more detail about data sources and data linkage.

## Run Shiny Server
```
source .envrc
$(aws ecr get-login --no-include-email)
docker-compose up
```
