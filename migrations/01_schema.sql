-- create tables for database
-- drop existing tables if the exist to ensure clean slate
DROP TABLE IF EXISTS users, reservations, property_reviews, properties CASCADE;

-- stores info about registered users
CREATE TABLE users (
  id       SERIAL PRIMARY KEY NOT NULL,
  name     VARCHAR(255) NOT NULL,
  email    VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- contains details about available rentals
CREATE TABLE properties (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,

  -- property details
  title VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_photo_url VARCHAR(255) NOT NULL,
  cover_photo_url     VARCHAR(255) NOT NULL,
  cost_per_night      INTEGER NOT NULL DEFAULT 0,
  parking_spaces      INTEGER NOT NULL DEFAULT 0,
  number_of_bedrooms  INTEGER NOT NULL DEFAULT 0,
  number_of_bathrooms INTEGER NOT NULL DEFAULT 0,

  -- property locations
  country   VARCHAR(255) NOT NULL,
  street    VARCHAR(255) NOT NULL,
  city      VARCHAR(255) NOT NULL,
  province  VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

 -- tracks bookings made by users
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  property_id INTEGER REFERENCES properties(id)  ON DELETE CASCADE,
  guest_id    INTEGER REFERENCES users(id)       ON DELETE CASCADE
);

  -- stores reviews left by users/guests
CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY NOT NULL,
  guest_id       INTEGER REFERENCES users(id)        ON DELETE CASCADE,
  property_id    INTEGER REFERENCES properties(id)   ON DELETE CASCADE,
  reservation_id INTEGER REFERENCES reservations(id) ON DELETE CASCADE,
  rating SMALLINT NOT NULL DEFAULT 0,
  message TEXT
);