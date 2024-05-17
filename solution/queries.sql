USE books;

-- 1. Which are the highest rated books? And per age group?
SELECT 
    books.isbn,
    books.bookTitle,
    AVG(ratings.bookRating) AS avg_rating,
    users.age
FROM ratings
JOIN books ON ratings.isbn = books.isbn
JOIN users ON ratings.userID = users.userID
WHERE users.age >= 35 AND users.age < 45 
GROUP BY books.isbn, books.bookTitle, users.age
ORDER BY avg_rating DESC
LIMIT 50;

-- 2. Which are the most reviewed books? And per age group?
SELECT
    books.isbn,
    books.bookTitle,
    COUNT(ratings.id) AS review_count,
    users.age
FROM ratings
JOIN books ON ratings.isbn = books.isbn
JOIN users ON ratings.userID = users.userID
WHERE users.age >= 35 AND users.age < 45  
GROUP BY ratings.isbn, books.bookTitle, users.age
ORDER BY review_count DESC
LIMIT 50;

-- 3. What books are most frequently rated together by the same user?
SELECT 
    books.bookTitle AS book1, 
    books2.bookTitle AS book2, 
    COUNT(*) AS frequency
FROM ratings AS ratings1
JOIN ratings AS ratings2 ON ratings1.userID = ratings2.userID AND ratings1.isbn = ratings2.isbn
JOIN books ON ratings1.isbn = books.isbn
JOIN books AS books2 ON ratings2.isbn = books2.isbn
GROUP BY books.bookTitle, books2.bookTitle
ORDER BY frequency DESC
LIMIT 50;

-- 4. What are the most polarizing books? 
SELECT
    books.isbn,
    books.bookTitle,
    COUNT(ratings.id) AS total_ratings,
    MAX(ratings.bookRating) AS max_rating,
    MIN(ratings.bookRating) AS min_rating,
    (MAX(ratings.bookRating) - MIN(ratings.bookRating)) AS rating_range
FROM ratings
JOIN books ON ratings.isbn = books.isbn
GROUP BY books.isbn, books.bookTitle
HAVING COUNT(ratings.id) >= 10  -- Minimum number of ratings to consider
ORDER BY rating_range DESC
LIMIT 50;

-- 6. What are some books that receive high, **but few**, ratings?
SELECT 
    books.isbn,
    books.bookTitle,
    AVG(ratings.bookRating) AS avg_rating,
    COUNT(ratings.bookRating) AS num_ratings
FROM books
JOIN ratings ON books.isbn = ratings.isbn
GROUP BY books.isbn, books.bookTitle
HAVING AVG(ratings.bookRating) >= 8 AND COUNT(ratings.bookRating) >= 5 
ORDER BY avg_rating DESC
LIMIT 50;

-- 9. What are the highest rated books, by country?
SELECT 
    books.isbn,
    books.bookTitle,
    AVG(ratings.bookRating) AS avg_rating,
    users.location
FROM books
JOIN ratings ON books.isbn = ratings.isbn
JOIN users ON ratings.userID = users.userID
WHERE users.location LIKE '%spain%' 
GROUP BY books.isbn, books.bookTitle, users.location
ORDER BY avg_rating DESC;