-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
CREATE TABLE comments_and_translations (
    id int,
    COMMENT varchar(100),
    translation varchar(100)
);

INSERT INTO
    comments_and_translations
VALUES
    (1, 'very good', NULL),
    (2, 'good', NULL),
    (3, 'bad', NULL),
    (4, 'ordinary', NULL),
    (5, 'cdcdcdcd', 'very bad'),
    (6, 'excellent', NULL),
    (7, 'ababab', 'not satisfied'),
    (8, 'satisfied', NULL),
    (9, 'aabbaabb', 'extraordinary'),
    (10, 'ccddccbb', 'medium');

SELECT
    COALESCE(translation, COMMENT) AS output
FROM
    comments_and_translations;