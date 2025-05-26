# Explain the **Primary Key** and **Foreign Key** concepts in PostgreSQL
## Primary Key
`Primary key` uniquely indetifies each rows in a table and it always ensure the data of the column is unique and never be duplicated into another column also it allows us to sequence the data and helps to manage a relational database perfectly.

### Characteristics
- Unique data
- To sequence the data
- To identify unique rows in a table
- Only one Primary key is allowed at the same timne on a table
- It should not be NULL and many others..

### Example
```sql
CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

INSERT INTO employes(employee_id, name) VALUES (1, 'ash'), ( 2, 'mizan');
SELECT * FROM employes WHERE employee_id = 1;

```


| employee_id | name |
| ------ | ------ |
| 1 | ash |
| 2 | mizan |


> Created table with Primary key --> employee_id
> Inserted multiple data with unique Primary key
> Identified unique data from a table


## Foreign Key

A `Foreign key` stublishes relationship between tables with referencing the `Primary key` of another table. It links data between multiple tables and ensure that each data is corresponding of each other.

### Characteristics
- Group of columns in a relational database table that provides a link between data in two tables
- The reference Foreign key is the Primary key of another table
- It can duplicate values in a table of a relaional database and more others..

### Example
```sql
CREATE TABLE dept (
  dept_id SERIAL PRIMARY KEY,
  dept_name TEXT NOT NULL
  FOREIGN KEY employee_id INT REFERENCES departments(employee_id)
);

INSERT INTO dept(dept_id, dept_name, employee_id) VALUES (1, 'system', 1), ( 2, 'database', 2);
```


| dept_id | name |employee_id |
| ------ | ------ | ------ | 
| 1 | system | 1 |
| 2 | database | 2 |

> Created table with Primary key --> dept_id and Foreign key --> employee_id
> Inserted multiple data with unique Primary key and Referencing the employee_id as Foreign key

-----
-----

# Difference between the `VARCHAR` and `CHAR` data types

## VARCHAR


