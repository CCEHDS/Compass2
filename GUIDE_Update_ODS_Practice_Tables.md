## Update ODS Practice Tables

Download *epraccur.zip* from
https://digital.nhs.uk/services/organisation-data-service/data-downloads/gp-and-gp-practice-related-data
Copy into SQLdata_Import/IMPORT folder

Run **CREATE_gppractice_copies.sql** -- creates copies of ods_gppractices and ceg_gppractices under old_im schema

Run **CREATE_odsgppractices.sql** -- drops and creates ods_gppractices table, with varchar fields for import

Edit **SQLdata_Import2.ps1** to include your database settings under # Set Variables
update the log file location, 
if needed set csv delimiter settings

Edit **RUN_SQLdata_Import.ps1** to give *SQLdata_Import2.psl* location, target table, csv file location.

Run **RUN_SQLdata_Import.ps1** -- Best to run from terminal, in order to see messages. Powershell may request Execution Policy Change to run script. Select Y.
Script calls SQLdata_Import to load each file into the table in the database 50000 rows at a time, using temporary memory tables.

Run **FORMAT_field_datatypes.sql** -- changes empty data to NULL and changes fields to appropriate datatypes.

Run **UPDATE_organization_id_from_eoc.sql** - adds in organization_id from episode_of_care table. (approx. 3mins)

A version updating from encounter table is also available.  Using episode_of_care means that only organisations in 'our patch' have an id. However, as organisations can have multiple ids as service providers, it could be a lottery as to which one ends up in the ods_gppractices.

Run **UPDATE_ceggppractices.sql** -- updates *ceg_gppractice.organization_id* and status from *ods_gppractices*

If not wanted, DROP the old gppractices tables now under old_im.
