# Explaination of the **Primary Key** and **Foreign Key** concepts in PostgreSQL
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

## CHAR
A data type is `sql` which is used to store fixed length data of a string character and stores the character in `n` bytes. It always stores exact `n` bytes of or specified `bytes` of data and if the the data size or length is less than the fixed or specified length `CHAR` wil added extra padded spaces or blank spaces.

### Characteristics
 - Stores the fixed character length of a string data type
 - Always stores  the data is equal to the fixed or specifed length
 - It takes 1 byte for each character
 - Best performance
 

### Example
```sql

CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  name CHAR(20) NOT NULL
);

INSERT INTO employes(employee_id, name) VALUES (1, 'ash'), ( 2, 'mizan bhai');
SELECT LENGTH(name) FROM employees;

```
#### output
```zsh
    LENGTH(name)
    20
    20
```

# VARCHAR
A data type in `sql` it stores characters of a string variable length with  maximum of set of the fixed length, that means it will allow us to store maximum length of the input without padded with extra blank spaces. It is equal to the input string length.

### Characteristics
- Stores the fixed character length of a input string data type as a variable length.
- It stores data as variable formate like the exact length of the input string.
- It is not padded with spaces though it takes 1 byte for each character but also take some bytes for holding the length informations.
- Less porformance compared to CHAR

### Example
```sql

CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL
);

INSERT INTO employes(employee_id, name) VALUES (1, 'ash'), ( 2, 'mizan bhai');
SELECT LENGTH(name) FROM employees;

```
#### output
```zsh
    LENGTH(name)
    3
    9
```

----
----
# Explaination the purpose of the `WHERE` clause in a `SELECT` statement

`WHERE` clause in `sql` is for filtering the data from a table when to retreiving , updating and deleting the records. `WHERE` clause plays important role when to work on specific data. There will be so many tables in a databse including each tables can contain multiple rows and column and data, It filters the `row` based on condition. In `SELECT` caluse we use it when to select a table or specify a table, The `WHERE` clause in a `SELECT` statement it filters the rows from the selected table based on specified conditions than returns the only row which met the specified condition as `TRUE` and filters data down to just based on rows only.

## Example
#### Table defination and sample data

```sql

CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  dept_id INT NOT NULL,
  gpa NUMERIC(3,2)
);

INSERT INTO students (name, dept_id, gpa) VALUES
  ('Alice',    1, 3.75),
  ('Bob',      2, 2.90),
  ('Charlie',  1, 3.10),
  ('Diana',    3, 3.95),
  ('Ethan',    2, 2.50);

````
### Use case: 
```sql
---Select students in department 1
 SELECT student_id, name, gpa
 FROM students
 WHERE dept_id = 1;

---Select students with GPA ≥ 3.00
 SELECT name, gpa
 FROM students
 WHERE gpa >= 3.00;

---Combine filters with AND / OR
 SELECT name, dept_id, gpa
 FROM students
 WHERE dept_id = 2
 AND gpa < 3.00;

````

> Selected student from dept 1; filtered output: Alice and Charlie only
> Filtering students based on gpa; output: Alice, Charlie, Diana
> Combination filtering with conditions; output:  Bob and Ethan

-----
-----

# Modify data using `UPDATE` statements
## UPDATE
`UPDATE` statement in `sql` allows to modify or update the exsiting rows in a table of a databse. It helps to update the data without inserting new one and let changes one or multiple column.

### Syntex 
```sql
UPDATE table_name
SET column1 = new_value, column2 = new_value, ...
WHERE condition;
```

> table_name: The target table
> SET: Lists one or more column = new_value assignments
> WHERE: (Optional but almost always needed) Filters which rows to change
> Without WHERE, every row in the table will be updated

### How to modify the data

```sql
---Create demo table
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name       VARCHAR(50),
  dept_id    INT,
  gpa        NUMERIC(3,2)
);

-- Sample data
INSERT INTO students (name, dept_id, gpa) VALUES
  ('Alice',   1, 3.75),
  ('Bob',     2, 2.90),
  ('Charlie', 1, 3.10);

---Update Alice gpa
UPDATE students
SET gpa = 3.85
WHERE name = 'Alice';

---Updating multiple column
UPDATE students
SET dept_id = 1,
gpa = 3.20
WHERE name = 'Bob';

---Updateing multiple rows
UPDATE students
SET gpa = gpa + 0.10
WHERE dept_id = 1;

```

----
----

# The `LIMIT` and `OFFSET` clauses

## `LIMIT`

`LIMIT` clause i used in `sql` to limit the number of rows returned by a query. It can used with the SELECT statement and can be very useful in large databases when needed a subset of the data from the database. It specifies the maximum number of rows to return and preserve query performance, optimize resource utilization, enforce security and privacy policies, and enhance usability on large tables.

### Syntex 
```sql
SELECT column1, column2, ...
FROM table LIMIT number_of_rows
```
### Usage
- Pagination
- Retrieving top records , etc

## `OFFSET`
`OFFSET` allows to skip a specified number of rows before returning the results fo the query.

### Syntex
```sql
OFFSET <skip_count>;
```

### Usage
- To skip specified rows before returning the query result
- Chunk Processing


### Combining `LIMIT` + `OFFSET`

`LIMIT` and `OFFSET` are often used together to achieve pagination, where you retrieve data in `pages`. `LIMIT` specifies how many rows to return on query while `OFFSET` indicates how many rows to skip and improving usability and performance. OFFSET changes the starting point of results, allowing for more flexible data retrieval. We can group and ordered the data that allows more accesable. 

### Usage Example
```sql
SELECT student_id, name
  FROM students
 ORDER BY student_id
 OFFSET 20   ---skip the first two pages (2×10 rows)
 LIMIT 10;   ---return the next 10 rows (rows 21–30)
```
