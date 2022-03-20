# CSI4142_project_WHB
Introduction to Data Science project Winter 2022

Data taken from the World Bank - Health and Nutrition and Population Statistics

Team members:
Matthew Tran
Tate Sharp
James Gilhespy

--------------

Notes:
- **create_upd.sql** is the primary "CREATE" script, which should load all dimensions.
- Currently the 'Education', 'Health', and 'Quality' tables are not linked to the fact table, due to a bug with our code.
- User will have to edit the location of the '/spreadsheets/' directory inside the create_upd.sql file. Each execution of '**COPY  table FROM </spreadsheets/ location> ...**' will require this change.
