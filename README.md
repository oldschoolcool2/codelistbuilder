# Aetion, Inc.
## Code List Builder
-------------

### Change Log
06/27/2018 - Converted all data files to use Feather format for better efficiency and added options to use 2- and 4- digit search on ICD-9 and ICD-10 codes. Also separated the ICD-9 and ICD-10 boxes from each other in the menu. Finally, added a message to show that the code list builder is live for funsies!

03/16/2021 - Branched for Aetion

## Run Shiny Server
```
source .envrc
$(aws ecr get-login --no-include-email)
docker-compose up
```
