# Canvas BASH Scripts

The purpose of these scripts is to create courses in [Instructure Canvas](https://www.instructure.com/canvas/), copy content from one course shell to another, and to enroll users in courses. They accept *CSV* files for input and made to run in the Terminal in Mac OS, but should work with any *NIX* system.

## Dependencies

These scripts require the use of [jq](https://stedolan.github.io/jq/download/).

## Contents

### Copy.sh and Copy.xlsx

Script to copy content from one Canvas course to another and a Microsoft Excel template of the CSV file the script uses for input.

*Note: The script currently depends on both Canvas courses being in the same subaccount.*

### Create.sh and Create.xlsx

Script to create Canvas courses and a Microsoft Excel template of the CSV file the script uses for input.

### Create_Sections.sh and Create_Sections.xlsx

Script to create sections in existing Canvas courses and a Microsoft Excel template of the CSV file the script uses for input.

### Enroll.sh and Enroll.xlsx

Script to enroll users into existing Canvas courses and a Microsoft Excel template of the CSV file the script uses for input.

### Enroll_Sections.sh and Enroll_Sections.xlsx

Script to enroll users into existing Canvas courses sections and a Microsoft Excel template of the CSV file the script uses for input.

