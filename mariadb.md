

-----------------------------------------------------------------------------

    + create user:
    
        - CREATE USER youssef;

-----------------------------------------------------------------------------

    + delete user:

        - DROP USER youssef

-----------------------------------------------------------------------------

CREATE USER 'hmza'@'%' IDENTIFIED BY 'hamza123';

-----------------------------------------------------------------------------

    + ادخل الي database

        - USE wordpress;

-----------------------------------------------------------------------------

    + اعرض كل الـ tables

        - SHOW TABLES;
    
-----------------------------------------------------------------------------

    + ادخل إلى Table معيّن

        - SELECT * FROM wp_posts;

    + أو إذا تريد فقط معرفة الأعمدة:

        - DESCRIBE user;

    + إذا أردت رؤية الصفحات والمنشورات:

        - SELECT ID, post_title, post_type, post_status
            FROM wp_posts;

-----------------------------------------------------------------------------

    + هي تشوف كاع user and host

    - SELECT User, Host FROM mysql.user;
    

-----------------------------------------------------------------------------


    -- ما هي صلاحيات هذا المستخدم؟

    SHOW GRANTS FOR 'ylagzoul'@'%';

-----------------------------------------------------------------------------
USE wordpress;

SHOW TABLES;

SELECT * FROM wp_users;

INSERT INTO wp_users ...;

UPDATE wp_users ...;

DELETE FROM wp_users ...;

CREATE TABLE test (...);

DROP TABLE test;
-----------------------------------------------------------------------------

    رايت password

 SHOW CREATE USER 'ylagzoul'@'%';
-----------------------------------------------------------------------------

mariadb -u wpuser -p
USE wordpress;
SHOW TABLES;
SELECT user_login FROM wp_users;

-----------------------------------------------------------------------------

SELECT option_name, option_value FROM wp_options WHERE option_name IN ('siteurl','blogname');
SELECT user_login, user_email FROM wp_users;
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

CREATE USER lagzoul@% IDENTIFIED BY rt123