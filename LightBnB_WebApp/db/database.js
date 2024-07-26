const properties = require("./json/properties.json");
const users = require("./json/users.json");

const { Pool } = require('pg');

const pool = new Pool({
  user: 'development',
  password: 'development',
  host: 'localhost',
  database: 'lightbnb'
});

// the following assumes that you named your connection variable `pool`
// pool.query(`SELECT title FROM properties LIMIT 10;`).then(response => {
//   console.log(response);
// });


/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */

// return pool is the same as return promise here
const getUserWithEmail = function(email) {
  return pool
    .query(`SELECT * FROM users WHERE email = $1`, [email])
    // chain to handle query results
    .then((result) => {
      // check if the rows were returned
      if (result.rows.length > 0) {
        return result.rows[0];
      } else {
        return null;
      }
    })
    .catch((err) => {
      return Promise.reject(err);
    });
};



/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  return pool
    .query(`SELECT * FROM users WHERE id = $1`, [id])
  // chain to handle query results
    .then((result) => {
    // check if the rows were returned
      if (result.rows.length > 0) {
        return result.rows[0];
      } else {
        return null;
      }
    })
    .catch((err) => {
      return Promise.reject(err);
    });
};


/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser = function(user) {
  return pool
    .query(`
      INSERT INTO users (name, email, password)
      VALUES ($1, $2, $3)
      RETURNING *
      `, [user.name, user.email, user.password])
    .then((result) => {
      return result.rows[0];
    })
    .catch((err) => {
      return Promise.reject(err);
    });
};


/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  return pool
    .query(`
  SELECT reservations.id AS reservation_id,
       properties.title,
       reservations.start_date,
       properties.cost_per_night,
       AVG(property_reviews.rating) AS avg_rating
FROM reservations
JOIN properties ON reservations.property_id = properties.id
LEFT JOIN property_reviews ON properties.id = property_reviews.property_id
WHERE reservations.guest_id = $1
GROUP BY reservations.id, properties.id
ORDER BY reservations.start_date ASC
LIMIT $2;`, [guest_id, limit])
    .then((result) => result.rows)
    .catch((err) => {
      return Promise.reject(err);
    });
};

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = (options, limit = 10) => {
  const queryParams = [];
  let queryString = `
  SELECT properties.*, AVG(property_review.rating) AS average_rating
  FROM properties
  LEFT JOIN property_reviews ON properties.id = property_id
  `;

  let whereClauseAdded = false;

  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `WHERE city LIKE $${queryParams.length}`;
    whereClauseAdded = true;
  }

  if (options.owner_id) {
    queryParams.push(options.owner_id);
    if (whereClauseAdded) {
      queryString += `AND owner_id = $${queryParams.length}`;
      whereClauseAdded = true;
    } else {
      queryString += `WHERE owner_id $${queryParams.length}`;
      whereClauseAdded = true;
    }
  }
  if (options.minimum_price_per_night && options.maximum_price_per_night) {
    queryParams.push(options.minimum_price_per_night * 100, options.maximum_price_per_night * 100);
    if (whereClauseAdded) {
      queryString += `AND cost_per_night >= $${queryParams.length - 1} AND cost_per_night <= $${queryParams.length} `;
    } else {
      queryString += `WHERE cost_per_night >= $${queryParams.length - 1} AND cost_per_night <= $${queryParams.length} `;
      whereClauseAdded = true;
    }
  }
  queryString += `GROUP BY properties.id`;

  if (options.minimum_rating) {
    queryParams.push(options.minimum_rating);
    queryString += `HAVING AVG(property_reviews.rating) >= $${queryParams.length}`;
  }

  queryParams.push(limit);
  queryString += `
  ORDER BY cost_per_night
  LIMIT $${queryParams.length};
  `;
  console.log(queryString, queryParams);

  return pool.query(queryString, queryParams)
    .then((res) => res.rows);
};
//This works because .then always returns a promise. Even though we wrote the line return result.rows (where result.rows is an array of objects), .then automatically places that value in a promise. .then returns a promise, which is returned as a result of the entire getAllProperties function.

/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
};

module.exports = {
  getUserWithEmail,
  getUserWithId,
  addUser,
  getAllReservations,
  getAllProperties,
  addProperty,
};
