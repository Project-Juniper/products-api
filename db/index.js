const { Pool } = require('pg');

// const pool = new Pool({
//   host: 'localhost',
//   database: 'productsapi'
// });

const pool = new Pool({
  user: 'david',
  host: 'add host here',
  database: 'onlineproductsapi',
  password: 'add password here',
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

module.exports.getStyleInfo = (id, callback) => {
  pool.query('SELECT DISTINCT * FROM Styles INNER JOIN Photos on Styles.id = Photos.styles_id WHERE Styles.product_id = $1', [id], (err, photosResults) => {
    if (err) {
      callback(err);
    } else {
      pool.query('SELECT DISTINCT * FROM Styles INNER JOIN Skus on Styles.id = Skus.styles_id WHERE Styles.product_id = $1', [id], (err, skusResults) => {
        if (err) {
          callback(err);
        } else {
          pool.query('SELECT * FROM Styles WHERE product_id = $1', [id], (err, generalResults) => {
            if (err) {
              callback(err);
            } else {
              const endResults = {
                product_id: id,
                results: []
              }
              let allSkusObj = {};
              skusResults.rows.forEach((sku => {
                if (Object.keys(allSkusObj).indexOf(`${sku.styles_id}`) === -1) {
                  allSkusObj[sku.styles_id] = {};
                  allSkusObj[sku.styles_id][sku.id] = {
                    quantity: sku.quantity,
                    size: sku.size
                  }
                } else {
                  allSkusObj[sku.styles_id][sku.id] = {
                    quantity: sku.quantity,
                    size: sku.size
                  }
                }
              }
              ))
              let allPhotosObj = {};
              photosResults.rows.forEach((photo => {
                if (Object.keys(allPhotosObj).indexOf(`${photo.styles_id}`) === -1) {
                  allPhotosObj[photo.styles_id] = [{
                    thumbnail_url: photo.thumbnail_url,
                    url: photo.photo_url
                  }]
                } else {
                  allPhotosObj[photo.styles_id].push({
                    thumbnail_url: photo.thumbnail_url,
                    url: photo.photo_url
                  });
                }
              }));

              generalResults.rows.forEach((style) => {
                endResults.results.push({
                  style_id: style.id,
                  name: style.style_name,
                  original_price: style.original_price + '.00',
                  sale_price: style.sale_price === 'null' ? null : style.sale_price,
                  'default?': style.default_style,
                  photos: allPhotosObj[style.id],
                  skus: allSkusObj[style.id]
                });
              });
              callback(null, endResults);
            }
          });
        }
      }
      )}
  });
};

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
};
