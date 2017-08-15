DROP DATABASE IF EXISTS tacodb;
CREATE DATABASE tacodb;

-- connect database (postgress specific) othr systems will be a different command to connect.

\c tacodb;

CREATE TABLE franchise(
  franchise_id  SERIAL PRIMARY KEY,
  rating FLOAT,
  price_point FLOAT,
  name VARCHAR(100) NOT NULL,
  authenticity INTEGER
);

CREATE TABLE location(
  location_id  SERIAL PRIMARY KEY,
  street VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  zip INTEGER,
  CHECK(zip > 9999 AND zip < 100000),
  franchise_id INTEGER,
  FOREIGN KEY (franchise_id) REFERENCES franchise(franchise_id)
);

CREATE TABLE menu_item(
  menu_id  SERIAL PRIMARY KEY,
  picture TEXT,
  course TEXT,
  price FLOAT,
  name TEXT,
  franchise_id INTEGER,
  FOREIGN KEY (franchise_id) REFERENCES franchise(franchise_id)
);
INSERT INTO franchise ( rating, price_point, name, authenticity)
VALUES ('4.5', '1', 'Tin N Taco', '5' );

INSERT INTO location ( street, city, zip, franchise_id)
VALUES ('Washington St', 'Orlando', '32801', (SELECT franchise_id FROM franchise WHERE name='Tin N Taco'));

INSERT INTO menu_item (course, price, name, franchise_id)
VALUES ('entree', '5.25', 'Cuban Press', (SELECT franchise_id FROM franchise WHERE name='Tin N Taco') ),
       ('entree', '5.25', 'Italian Press', (SELECT franchise_id FROM franchise WHERE name='Tin N Taco') ),
       ('entree', '5.25', 'Veggie Press', (SELECT franchise_id FROM franchise WHERE name='Tin N Taco') ),
       ('entree', '5.25', 'Sante Fe Chicken Press', (SELECT franchise_id FROM franchise WHERE name='Tin N Taco') ),
       ('entree', '5.95', 'Turkey Club Wrap', (SELECT franchise_id FROM franchise WHERE name='Tin N Taco') );

INSERT INTO franchise (name, rating, price_point, authenticity)
 VALUES
 ('Taquerias Arandinas', 4.8, 2, 1);

INSERT INTO menu_item (name, course, price, picture, franchise_id)
   VALUES
   ('Torta Cubana', 'Entre', 5.99, '', (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('Botana Arandinas ', 'Entre', 9.99, '', (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('Chicharron / Pork Skin', 'Appetizer', 2.10, '', (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('Al Pastor - Barbacoa - Adobada', 'Appetizer', 2.10, '', (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('Tres Leches Cake', 'Dessert', 3.99, '', (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('Flan Napolitano', 'Dessert', 3.99, '', (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas'));

 INSERT INTO location (street, city, zip, franchise_id)
 VALUES
   ('700 William Cannon Dr.', 'Austin', 78745, (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('2110 E. Riverside Dr.', 'Austin', 78741, (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas')),
   ('1011 Reinli St', 'Austin', 78723, (SELECT franchise_id FROM franchise WHERE name='Taquerias Arandinas'));

INSERT INTO franchise(rating, price_point, name, authenticity) VALUES (3.5,2,'San Joses Original Mexican Restaurant', '0');

INSERT INTO location(street, city, zip, franchise_id)
  VALUES ('8995 W Colonial Dr', 'Ocoee', 34761, (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')), ('4315 S. Hwy 27','Clermont',34711, (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')),
  ('280 S. State Rd 434','Altamonte Springs',32714, (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')),
  ('1337 S 14th St','Leesburg',34747, (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant'));

INSERT INTO menu_item(picture,course,price,name, franchise_id) VALUES ('http://tacobell.com.gt/wp-content/uploads/2011/06/burrito_supreme-cropped2.png','Lunch Supreme',7.99,'Burrito Supreme', (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')), ('https://cdn.trendhunterstatic.com/thumbs/fast-food-vegan-options.jpeg','Lunch Supreme',8.49,'Stuffed Burrito', (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')),
  ('http://c8.alamy.com/comp/FY6W9T/mexican-combo-beef-and-chicken-fajitas-with-shrimp-FY6W9T.jpg','Lunch Supreme',7.99,'Chicken Combo', (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')),
  ('https://s3-media2.fl.yelpcdn.com/bphoto/tiK5TFtXeZyOu69ciwUzow/o.jpg','Lunch Supreme',7.99,'Quesadilla Rellena', (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')),
  ('https://www.orwhateveryoudo.com/wp-content/uploads/2015/06/Loaded-Nachos-Supreme-4.jpg','Lunch Supreme',7.99,'Nachos Supreme', (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant')),
  ('https://whatscookingamerica.net/wp-content/uploads/2015/03/Chimichanga26.jpg','Lunch Supreme',8.49,'Chimichanga', (SELECT franchise_id FROM franchise WHERE name='San Joses Original Mexican Restaurant'));

INSERT INTO franchise (rating, price_point, name, authenticity)
  VALUES(3.8,2.79,'Taco Bell', 0);

INSERT INTO menu_item (picture, course, price, name, franchise_id)
  VALUES('http://cdn.foodbeast.com.s3.amazonaws.com/content/wp-content/uploads/2013/07/taco-bell-cinnamon-twists.jpg','Dessert',.89,'cinnamon twists', (SELECT franchise_id FROM franchise WHERE name='Taco Bell')),
  ('https://www.munchiesgrubclub.com/wp-content/uploads/2016/08/pdp_cheesy_fiesta_potatoes.jpg','Appetizer',1.29,'cheesy fiesta potatoes', (SELECT franchise_id FROM franchise WHERE name='Taco Bell')),
  ('http://www.lifeaslars.com/journal/wp-content/uploads/2015/05/pdp_quesarito.jpg','Main course',2.69,'Beef quesarito', (SELECT franchise_id FROM franchise WHERE name='Taco Bell')),
  ('http://4.bp.blogspot.com/-1tNpvNnSE2c/UoI7DhqjzOI/AAAAAAAAZRE/-uTZ7dHwuYo/s1600/Taco-Bell-Cinnabon-Delights.jpg','Desert',1.00,'cinnabon delights', (SELECT franchise_id FROM franchise WHERE name='Taco Bell'));

INSERT INTO location (street, city, zip, franchise_id)
  VALUES('4225 east colonial drive','Orlando',32803, (SELECT franchise_id FROM franchise WHERE name='Taco Bell')),
  ('690 South Orlando ave','Winter Park',32789, (SELECT franchise_id FROM franchise WHERE name='Taco Bell')),
  ('2600 Orlando West drive','Orlando',32808, (SELECT franchise_id FROM franchise WHERE name='Taco Bell'))
