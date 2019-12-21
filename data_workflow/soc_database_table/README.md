# Create database, schema and table

```
sudo -u postgres psql -f lca_schema.sql
```

Note: The above will create the database, schema and lca_program table. And also it will create `lca_program` user with password `lca_program`

# Running sync script
Note: Make sure that `requirements.txt` got installed in virtualenv or in the environment.

Python - Runtime: 3.5+

`pip3 install -r requirements.txt`

`python3 syncdata.py ../data/soc_structure_2018.xlsx`

# Queries to fetch data

`Get all Major Groups`

```
select name, title from lca_group where type='Major Group';
```

# Using docker-compose

```
cd data_workflow/soc_database_table
docker-compose up
```