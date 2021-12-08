const { Pool } = require('pg');
const { secretPW } = require('../dbPassword.js');

const pool = new Pool({
  user: 'david',
  host: '13.57.15.90',
  database: 'onlineproductsapi',
  password: secretPW,
  port: 5432
});

module.exports.getItemInfo = (id, callback) => {
  pool.query('SELECT * FROM Products WHERE id = $1', [id], (err, productsResults) => {
    if (err) {
      callback(err);
    } else {
      const results = {
        id: id,
        name: productsResults.rows[0].product_name,
        slogan: productsResults.rows[0].slogan,
        description: productsResults.rows[0].product_description,
        category: productsResults.rows[0].category_id,
        default_price: JSON.stringify(productsResults.rows[0].default_price) + '.00',
        features: []
      };
      pool.query('SELECT * FROM FEATURES WHERE product_id = $1', [id], (error, featuresResults) => {
        if (error) {
          callback(error);
        } else {
          featuresResults.rows.forEach((feat) => {
            results.features.push({ feature: feat.feature, value: feat.feature_value });
          });
        }
        callback(null, results);
      });
    }
  });
};

module.exports.getStyleInfo = async (id, callback) => {
  try {
    const result = await pool.query(`SELECT id as style_id, style_name as name, original_price, sale_price, default_style as "default?",
    (
      SELECT json_agg(x) FROM (
        SELECT thumbnail_url, photo_url as url FROM photos WHERE styles_id = styles.id
      ) x
    ) photos,
    (
      SELECT json_object_agg(id, x) FROM (
        SELECT id, quantity, size FROM skus WHERE styles_id = styles.id
      ) as x
    ) skus
    FROM styles WHERE product_id = ${id}`);

    const sendingResults = {
      product_id: id,
      results: result.rows
    };

    callback(null, sendingResults);
  } catch(err) {
    callback(null);
  }
}


module.exports.getRelatedInfo = (id, callback) => {
  pool.query('SELECT * FROM Related WHERE current_product_id = $1', [id], (err, relatedResults) => {
    if (err) {
      callback(err);
    } else {
      const results = [];
      relatedResults.rows.forEach((related) => {
        results.push(related.related_product_id);
      });
      callback(null, results);
    }
  });
}