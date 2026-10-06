┌──(ylagzoul㉿kali)-[~/inception/srcs/requirements/mariadb]
└─$ docker exec -it  cc2 bash 
root@b8ae0187a355:/# mariadb -u root
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
root@b8ae0187a355:/# mariadb -u root -p 
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 4
Server version: 10.11.18-MariaDB-0+deb12u1 Debian 12

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> \t
Outfile disabled.
MariaDB [(none)]> SHOW DATABES;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'DATABES' at line 1
MariaDB [(none)]> SHOW DATABS;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'DATABS' at line 1
MariaDB [(none)]> SHOW DATABAS;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'DATABAS' at line 1
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.104 sec)

MariaDB [(none)]> 
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.000 sec)

MariaDB [(none)]> use wordpress
Database changed
MariaDB [wordpress]> SHOW TABLES;
Empty set (0.000 sec)

MariaDB [wordpress]> use MYSQL
ERROR 1049 (42000): Unknown database 'MYSQL'
MariaDB [wordpress]> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [mysql]> SHOW TABLES
    -> ;
+---------------------------+
| Tables_in_mysql           |
+---------------------------+
| column_stats              |
| columns_priv              |
| db                        |
| event                     |
| func                      |
| general_log               |
| global_priv               |
| gtid_slave_pos            |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| index_stats               |
| innodb_index_stats        |
| innodb_table_stats        |
| plugin                    |
| proc                      |
| procs_priv                |
| proxies_priv              |
| roles_mapping             |
| servers                   |
| slow_log                  |
| table_stats               |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
| transaction_registry      |
| user                      |
+---------------------------+
31 rows in set (0.001 sec)

MariaDB [mysql]> FROM user SELECT *;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM user SELECT *' at line 1
MariaDB [mysql]> SELECT * FROM user;
+-----------+-------------+-------------------------------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+---------------------+----------+------------+-------------+--------------+---------------+-------------+-----------------+----------------------+-----------------------+-------------------------------------------+------------------+---------+--------------+--------------------+
| Host      | User        | Password                                  | Select_priv | Insert_priv | Update_priv | Delete_priv | Create_priv | Drop_priv | Reload_priv | Shutdown_priv | Process_priv | File_priv | Grant_priv | References_priv | Index_priv | Alter_priv | Show_db_priv | Super_priv | Create_tmp_table_priv | Lock_tables_priv | Execute_priv | Repl_slave_priv | Repl_client_priv | Create_view_priv | Show_view_priv | Create_routine_priv | Alter_routine_priv | Create_user_priv | Event_priv | Trigger_priv | Create_tablespace_priv | Delete_history_priv | ssl_type | ssl_cipher | x509_issuer | x509_subject | max_questions | max_updates | max_connections | max_user_connections | plugin                | authentication_string                     | password_expired | is_role | default_role | max_statement_time |
+-----------+-------------+-------------------------------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+---------------------+----------+------------+-------------+--------------+---------------+-------------+-----------------+----------------------+-----------------------+-------------------------------------------+------------------+---------+--------------+--------------------+
| localhost | mariadb.sys |                                           | N           | N           | N           | N           | N           | N         | N           | N             | N            | N         | N          | N               | N          | N          | N            | N          | N                     | N                | N            | N               | N                | N                | N              | N                   | N                  | N                | N          | N            | N                      | N                   |          |            |             |              |             0 |           0 |               0 |                    0 | mysql_native_password |                                           | Y                | N       |              |           0.000000 |
| localhost | root        | *FAAFFE644E901CFAFAEC7562415E5FAEC243B8B2 | Y           | Y           | Y           | Y           | Y           | Y         | Y           | Y             | Y            | Y         | Y          | Y               | Y          | Y          | Y            | Y          | Y                     | Y                | Y            | Y               | Y                | Y                | Y              | Y                   | Y                  | Y                | Y          | Y            | Y                      | Y                   |          |            |             |              |             0 |           0 |               0 |                    0 | mysql_native_password | *FAAFFE644E901CFAFAEC7562415E5FAEC243B8B2 | N                | N       |              |           0.000000 |
| localhost | mysql       | invalid                                   | Y           | Y           | Y           | Y           | Y           | Y         | Y           | Y             | Y            | Y         | Y          | Y               | Y          | Y          | Y            | Y          | Y                     | Y                | Y            | Y               | Y                | Y                | Y              | Y                   | Y                  | Y                | Y          | Y            | Y                      | Y                   |          |            |             |              |             0 |           0 |               0 |                    0 | mysql_native_password | invalid                                   | N                | N       |              |           0.000000 |
| %         | ylagzoul    | *D43F5429AA742C9D331EF08F197BB689A003C119 | N           | N           | N           | N           | N           | N         | N           | N             | N            | N         | N          | N               | N          | N          | N            | N          | N                     | N                | N            | N               | N                | N                | N              | N                   | N                  | N                | N          | N            | N                      | N                   |          |            |             |              |             0 |           0 |               0 |                    0 | mysql_native_password | *D43F5429AA742C9D331EF08F197BB689A003C119 | N                | N       |              |           0.000000 |
+-----------+-------------+-------------------------------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+---------------------+----------+------------+-------------+--------------+---------------+-------------+-----------------+----------------------+-----------------------+-------------------------------------------+------------------+---------+--------------+--------------------+
4 rows in set (0.001 sec)

MariaDB [mysql]> clear
MariaDB [mysql]> 
MariaDB [mysql]> SELECT Host, User FROM user;
+-----------+-------------+
| Host      | User        |
+-----------+-------------+
| %         | ylagzoul    |
| localhost | mariadb.sys |
| localhost | mysql       |
| localhost | root        |
+-----------+-------------+
4 rows in set (0.001 sec)

MariaDB [mysql]> exiyt
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'exiyt' at line 1
MariaDB [mysql]> exit
Bye
root@b8ae0187a355:/# mariadb -u root -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 5
Server version: 10.11.18-MariaDB-0+deb12u1 Debian 12

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.001 sec)

MariaDB [(none)]>  USE wordpress
Database changed
MariaDB [wordpress]> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [mysql]> SHOW TABELS
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'TABELS' at line 1
MariaDB [mysql]> SHOW TABELS
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'TABELS' at line 1
MariaDB [mysql]> SHOH TABLE;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SHOH TABLE' at line 1
MariaDB [mysql]> SHOH TABLES;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SHOH TABLES' at line 1
MariaDB [mysql]> SHOH TABELES;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SHOH TABELES' at line 1
MariaDB [mysql]> SHOH TABELS;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SHOH TABELS' at line 1
MariaDB [mysql]> SHOW TABLES;
+---------------------------+
| Tables_in_mysql           |
+---------------------------+
| column_stats              |
| columns_priv              |
| db                        |
| event                     |
| func                      |
| general_log               |
| global_priv               |
| gtid_slave_pos            |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| index_stats               |
| innodb_index_stats        |
| innodb_table_stats        |
| plugin                    |
| proc                      |
| procs_priv                |
| proxies_priv              |
| roles_mapping             |
| servers                   |
| slow_log                  |
| table_stats               |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
| transaction_registry      |
| user                      |
+---------------------------+
31 rows in set (0.001 sec)

MariaDB [mysql]> SELCTE Host , User FROM user;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SELCTE Host , User FROM user' at line 1
MariaDB [mysql]> SELECT Host , User FROM user;
+-----------+-------------+
| Host      | User        |
+-----------+-------------+
| %         | ylagzoul    |
| localhost | mariadb.sys |
| localhost | mysql       |
| localhost | root        |
+-----------+-------------+
4 rows in set (0.001 sec)

MariaDB [mysql]>


-----------------------------------------------------------------------------

docker exec <container> mariadb -u root -p -e "SHOW VARIABLES LIKE 'port';"

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

## الدخول للـ database

### 1. دخل لحاوية MariaDB

```bash
docker exec -it mariadb bash
```
(`mariadb` هنا هو اسم الحاوية. تقدر تشوفو بـ `docker ps`.)

### 2. دخل لـ MariaDB

```bash
mariadb -u "$DB_USER" -p
```
وكتب كلمة السر. أو بالقيم مباشرة:
```bash
mariadb -u wpuser -p wordpress
```
إلا بغيتي صلاحيات كاملة، دخل بـ root:
```bash
mariadb -u root -p
```

أو مباشرة من برا بأمر واحد، بلا ما تدخل للحاوية:
```bash
docker exec -it mariadb mariadb -u wpuser -p
```

### 3. اختار الـ database

```sql
SHOW DATABASES;
USE wordpress;
SHOW TABLES;
```
(`wordpress` هو `$DB_NAME`.)

## أوامر SQL للجداول

**`wp_users`** (المستخدمين):
```sql
SELECT ID, user_login, user_email, user_registered FROM wp_users;
```

**`wp_usermeta`** (الأدوار والمعلومات الإضافية):
```sql
SELECT user_id, meta_key, meta_value
FROM wp_usermeta
WHERE meta_key = 'wp_capabilities';
```
هنا غادي تشوف الدور ديال كل مستخدم (`administrator`, `author`).

**`wp_options`** (إعدادات الموقع):
```sql
SELECT option_name, option_value
FROM wp_options
WHERE option_name IN ('siteurl', 'home', 'blogname', 'admin_email');
```

## ربط المستخدم بالدور (JOIN)

```sql
SELECT u.user_login, u.user_email, m.meta_value AS role
FROM wp_users u
JOIN wp_usermeta m ON u.ID = m.user_id
WHERE m.meta_key = 'wp_capabilities';
```
هادي كتعطيك: اسم المستخدم، الإيميل، والدور فجدول واحد. هادشي مزيان تعرضو للمصحح.

## ملاحظات

- **كلمة السر** فـ `user_pass` غادي تبان hash طويل (`$P$B...`)، ماشي النص الأصلي.
- الـ prefix `wp_` هو الافتراضي. إلا كان مختلف، شوف:
  ```sql
  SHOW TABLES;
  ```
- إلا طلعلك `Access denied`، تأكد أن المستخدم والكلمة السر هما نفس اللي صاوبتي فسكريبت MariaDB.
- ولي ما بغيتيش تدخل فالـ SQL، تقدر تستعمل WP-CLI:
  ```bash
  wp user list --path=/var/www/html --allow-root
  ```

## جواب قصير للمصحح

> "I enter the MariaDB container with `docker exec`, connect with `mariadb -u <user> -p`, select the WordPress database with `USE`, and run SQL queries. For example, `SELECT * FROM wp_users;` shows the admin and the author I created."
-------------------------------------------------------------------------------------------------

what is mariadb and mysqladmin and  mariadbd and mysql and mariadb-server and mysqld? what is defirent 