-- Insert values into the table

-- add new users to the users table

INSERT INTO users (name, email, password)
VALUES ('James Hetfield', 'Hetfield@metallica.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Jon Bon Jovi', 'deadoralive@bonjovi.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Saul Hudson', 'slash@gunsnroses.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u');

-- adding properties to the properties table
INSERT INTO properties (
  owner_id,
  title, description, thumbnail_photo_url, cover_photo_url,
  cost_per_night, parking_spaces, number_of_bedrooms, number_of_bathrooms,
  country, street, city, province, post_code, active
)
  VALUES (1, 'Speed Lamp', 'description', 'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg', 93061, 6, 4, 8, 'Canada', '536 namsub Highway', 'Sotboske', 'Quebec', '28142', true),
  (1, 'Blank corner', 'description', ' https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg?auto=compress&cs=tinysrgb&h=350', ' https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg', 85234, 6, 6, 7, 'Canada', '651 Nami Road', 'Bohbatev', 'Alberta', '83680', true),
  (2, 'Habit mix', 'description', 'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg', 46058, 0, 5, 6, 'Canada', '1650 Hejto Center', 'Genwezu', 'Newfoundland And Labrador', 44583, true
  );

-- inserting new resveration data
INSERT INTO reservations (start_date, end_date, property_id, guest_id)
VALUES ('2018-09-11', '2018-09-26', 2, 3),
       ('2019-01-04', '2019-02-01', 2, 2),
       ('2023-10-01', '2023-10-14', 1, 3
);

-- inserting property reviews to table
INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating, message)
VALUES (3, 2, 1, 3, 'messages'),
       (2, 2, 2, 4, 'messages'),
       (3, 1, 3, 4, 'messages');