const { Pool } = require('pg');

const pool = new Pool({
  // user: 'postgres',
  // host: 'localhost',
  database: 'productsapi',
  // password: '',
  // port: 5432,
});

// pool.query('SELECT NOW()', (err, res) => {
//   console.log(err, res);
//   pool.end();
// });

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
            callback(null, results);
          });
        }
      });
    }
  });
};

module.exports.getStyleInfo = (id, callback) => {
  pool.query('SELECT * FROM Styles WHERE product_id = $1', [id], (err, stylesResults) => {
    if (err) {
      callback(err);
    } else {
      const endResults = {
        product_id: id,
        results: []
      };
      console.log('stylesResults.rows');
      console.log(stylesResults.rows);
      stylesResults.rows.forEach((style) => {
        const stylePhotos = [];
        pool.query('SELECT * FROM Photos WHERE styles_id = $1', [style.id], (err, photosResults) => {
          if (err) {
            console.log('No photos?')
          } else {
            photosResults.rows.forEach((photo) => {
              stylePhotos.push({
                thumbnail_url: photo.thumbnail_url,
                url: photo.photo_url
              })
            })
          }
        })
        const styleSkus = {};
        pool.query('SELECT * FROM Skus WHERE styles_id = $1', [style.id], (err, skusResults) => {
          if (err) {
            console.log('No skus?');
          } else {
            console.log('these are Sku results');
            console.log(skusResults.rows);
            skusResults.rows.forEach((sku) => {
              styleSkus[sku.id] = {
                quantity: sku.quantity,
                size: sku.size
              }
            })
          }
        })
        endResults.results.push({
          style_id: style.id,
          name: style.style_name,
          original_price: style.original_price,
          sale_price: style.sale_price,
          'default?': style.default_style,
          photos: stylePhotos,
          skus: styleSkus
        })
        console.log('this is endResults');
        console.log(endResults)
      })
      callback(null, endResults);
    }
  })
}

module.exports.getRelatedInfo = (id, callback) => {
  pool.query('SELECT * FROM Related WHERE current_product_id = $1', [id], (err, relatedResults) => {
    if (err) {
      callback(err);
    } else {
      const results = [];
      relatedResults.rows.forEach((related) => {
        results.push(related.related_product_id)
      })
      callback(null, results);
    }
  })
}