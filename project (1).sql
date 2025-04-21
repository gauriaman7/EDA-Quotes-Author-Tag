create database project;
use project;

-- number of quotes by each author

SELECT author, COUNT(*) AS quote_count
FROM quotes
GROUP BY author
ORDER BY quote_count DESC;

-- top 5 most common tags

SELECT tag, COUNT(*) AS tag_count
FROM (
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(tags, ',', numbers.n), ',', -1)) AS tag
    FROM quotes
    JOIN (
        SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
        UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
    ) numbers ON CHAR_LENGTH(tags) - CHAR_LENGTH(REPLACE(tags, ',', '')) >= numbers.n - 1
) AS all_tags
GROUP BY tag
ORDER BY tag_count DESC
LIMIT 5;

-- authors who have more than 5 quotes

SELECT author, COUNT(*) AS quote_count
FROM quotes
GROUP BY author
HAVING COUNT(*) > 5
ORDER BY quote_count DESC;

-- the longest quote and its author

SELECT author, quote, CHAR_LENGTH(quote) AS quote_length
FROM quotes
ORDER BY quote_length DESC
LIMIT 1;

-- top 5 contributor

SELECT author, COUNT(*) AS quote_count
FROM quotes
GROUP BY author
ORDER BY quote_count DESC
LIMIT 5;

-- author who write most on love

SELECT author, COUNT(*) AS love_quote_count
FROM quotes
WHERE tags LIKE '%love%'
GROUP BY author
ORDER BY love_quote_count DESC
LIMIT 1;

-- author who write most on inspirational

SELECT author, COUNT(*) AS inspiration_quote_count
FROM quotes
WHERE tags LIKE '%inspirational%'
GROUP BY author
ORDER BY inspiration_quote_count DESC
LIMIT 1;

-- quotes which have most tags

SELECT quote, author, tags, 
       (LENGTH(tags) - LENGTH(REPLACE(tags, ',', '')) + 1) AS tag_count
FROM quotes
ORDER BY tag_count DESC
LIMIT 1;

-- quotes which contains word happiness

SELECT author, quote
FROM quotes
WHERE quote LIKE '%happiness%';

-- SUMMARY --

-- The most quoted author on the website is Albert Einstein.
-- The most used tag is love.
