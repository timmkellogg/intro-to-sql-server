--CREATE TABLE Author (
--	AuthorID INT IDENTITY(1,1) PRIMARY KEY,
--	AuthorName VARCHAR(100) NOT NULL
--)


--DROP TABLE Author

--CREATE TABLE Book (
--	BookID INT IDENTITY(1,1) PRIMARY KEY,
--	Title VARCHAR(250) NOT NULL, 
--	Genre VARCHAR(50), 
--	AuthorID INT FOREIGN KEY REFERENCES Author(AuthorID),
--)

--INSERT INTO Author(AuthorName)
--VALUES('J.R.R. Tolkien')

--INSERT INTO Book(Title, Genre, AuthorID)
--VALUES('Cat''s Cradle', 'Sci-FI', 1)


SELECT Book.Title, Author.AuthorName
FROM Book
JOIN Author ON Book.AuthorID = Author.AuthorID