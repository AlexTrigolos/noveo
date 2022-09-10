CREATE TABLE authors
(
    id Serial PRIMARY KEY,
    firstName CHARACTER VARYING(30) NOT NULL,
    lastName CHARACTER VARYING(30) NOT NULL,
    Age INTEGER NOT NULL
);

CREATE TABLE books
(
    id SERIAL PRIMARY KEY,
    title CHARACTER VARYING(50) NOT NULL,
    author_id INTEGER NOT NULL,
    copies_sold INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE
);

INSERT into authors(firstName, lastName, Age) VALUES('bendgi', 'frank', 1000);
INSERT into authors(firstName, lastName, Age) VALUES('young', 'boy', 9);
INSERT into authors(firstName, lastName, Age) VALUES('old', 'woman', 82);

INSERT into books(title, author_id, copies_sold) VALUES('voina i mir', 1, 999999);
INSERT into books(title, author_id, copies_sold) VALUES('poison tree', 1, 534);
INSERT into books(title, author_id, copies_sold) VALUES('author_third', 1, 534);

INSERT into books(title, author_id, copies_sold) VALUES('moio detstvo', 2, 73);
INSERT into books(title, author_id, copies_sold) VALUES('quantum physics', 2, 12321);

INSERT into books(title, author_id, copies_sold) VALUES('v chiom smisl zizni', 3, 7654);
INSERT into books(title, author_id, copies_sold) VALUES('highway to hell', 3, 777);

SELECT authors.firstname from authors
WHERE length(authors.firstname) > 3 -- 3 а не 6, потому что нет авторов с имененм больше 6

SELECT age, COUNT(DISTINCT age) as author_count
FROM authors
GROUP BY age;

SELECT * FROM books
ORDER BY copies_sold desc
LIMIT 3

SELECT authors.firstname, authors.lastname, authors.age, (
  SELECT COUNT(*) as author_count FROM books 
  WHERE authors.id = books.author_id
) as books_count
FROM authors

DROP TABLE books;
DROP TABLE authors;