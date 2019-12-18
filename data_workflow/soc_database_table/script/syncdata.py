"""
Program to load the soc_structure_2018.xlsx
"""
import os
import sys
import xlrd
import psycopg2

_TYPES = [
    "Major Group",
    "Minor Group",
    "Broad Group",
    "Detailed Occupation"
]

HIERARCHY = [
    None, None, None, None
]


DB_CONFIG = {
    "database":os.getenv('DB_NAME', "lca_program"),
    "user":os.getenv('DB_USER', "lca_program"),
    "password": os.getenv('DB_PASSWORD', "lca_program"),
    "host": os.getenv('DB_HOST', "127.0.0.1"),
    "port": os.getenv('DB_PORT', "5432"),
}

# Read the source file (xlsx)
input_file = sys.argv[1]
loc = (input_file) 

wb = xlrd.open_workbook(loc) 
sheet = wb.sheet_by_index(0)
DATA_STARTS_FROM = 8 # This is where actual data is starting from
conn = psycopg2.connect(**DB_CONFIG)
print("Opened database successfully")
pk_map = {}
cur = conn.cursor()
# records = []
for row in range(DATA_STARTS_FROM, sheet.nrows):
    record = {"parent": ""}
    value_at = None
    value = None
    for col in range(sheet.ncols):
        _value = sheet.cell_value(row, col)
        if col == 4:
            record['title'] = _value
        else:
            if _value:
                value_at, value = col, _value
    record["type"] = _TYPES[value_at]
    HIERARCHY[value_at] = value
    record["name"] = value
    if record['type'] != 'Major Group':
        record['parent'] = HIERARCHY[value_at - 1]
    record.update({
        'id': row+1,
        'parent_id': pk_map[record['parent']] if record['parent'] else 'null'
    })
    cur.execute("INSERT INTO lca_group (id, name, type, title, parent) \
        VALUES ({id}, '{name}', '{type}', '{title}', {parent_id})".format(**record))
    pk_map.update({
        record['name']: row+1
    })
    
conn.commit()
print("Records created successfully")
conn.close()