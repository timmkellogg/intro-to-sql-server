-- Drop the database if it already exists
DROP DATABASE IF EXISTS vacation_attractions
GO

-- Create the database
CREATE DATABASE vacation_attractions;
GO

-- Use the database
USE vacation_attractions;
GO

-- Create the states table
CREATE TABLE states (
    state_id INT IDENTITY(1,1) PRIMARY KEY,
    state_name VARCHAR(255) NOT NULL,
    state_abbreviation VARCHAR(2) NOT NULL,
    capital_city VARCHAR(255) NOT NULL
);
GO

-- Create the attractions table
CREATE TABLE attractions (
    attraction_id INT IDENTITY(1,1) PRIMARY KEY,
    attraction_name VARCHAR(255) NOT NULL,
    attraction_description TEXT,
    price_of_admission DECIMAL(10, 2),
    state_id INT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);
GO

-- Insert data into the states table
INSERT INTO states (state_name, state_abbreviation, capital_city) VALUES
('California', 'CA', 'Sacramento'),
('New York', 'NY', 'Albany'),
('Texas', 'TX', 'Austin'),
('Florida', 'FL', 'Tallahassee'),
('Colorado', 'CO', 'Denver');
GO

-- Insert data into the attractions table
INSERT INTO attractions (attraction_name, attraction_description, price_of_admission, state_id) VALUES
('Golden Gate Bridge', 'Iconic suspension bridge spanning the Golden Gate Strait', NULL, 1),
('Central Park', 'Expansive park in the heart of Manhattan with various attractions', 10.00, 2),
('Alamo', 'Historic site where Texan soldiers fought for independence', NULL, 3),
('Walt Disney World', 'Massive entertainment complex featuring theme parks and resorts', 109.99, 4),
('Rocky Mountain National Park', 'Scenic park with diverse wildlife, hiking trails, and mountain views', NULL, 5),
('Yosemite National Park', 'Renowned for its waterfalls, giant sequoia trees, and granite cliffs', NULL, 1),
('Empire State Building', 'Iconic skyscraper offering observation decks and city views', 39.00, 2),
('Space Center Houston', 'Educational center and museum showcasing space exploration', 29.95, 3),
('Everglades National Park', 'Vast wetland preserve known for its unique ecosystem and wildlife', NULL, 4),
('San Francisco Museum of Modern Art', 'Contemporary art museum featuring works by notable artists', 25.00, 1),
('Times Square', 'Vibrant commercial and entertainment hub in the heart of NYC', NULL, 2),
('Six Flags Fiesta Texas', 'Amusement park featuring thrill rides, shows, and water attractions', 59.99, 3);
GO

-- List all states
SELECT * FROM states;
GO

-- List all attractions with state names
SELECT a.attraction_id, a.attraction_name, a.attraction_description, a.price_of_admission, s.state_name
FROM attractions a
JOIN states s ON a.state_id = s.state_id;
GO

-- List all free attractions
SELECT * FROM attractions WHERE price_of_admission IS NULL OR price_of_admission = 0;
GO

-- Update the price of admission for a free attraction
UPDATE attractions SET price_of_admission = 5.00 WHERE attraction_name = 'Alamo';
GO

-- List all free attractions after update
SELECT * FROM attractions WHERE price_of_admission IS NULL OR price_of_admission = 0;
GO

-- Delete an attraction
DELETE FROM attractions WHERE attraction_name = 'Times Square';
GO

-- List all attractions after deletion
SELECT * FROM attractions;
GO

-- Add a new attraction
INSERT INTO attractions (attraction_name, attraction_description, price_of_admission, state_id) 
VALUES ('Yellowstone National Park', 'Famous for its geothermal features and wildlife', NULL, 5);
GO

-- List all attractions after addition
SELECT * FROM attractions;
GO