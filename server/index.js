const express = require('express');
const cors = require('cors');
// const { GH_TOKEN } = require('../tokens.js');
// const { outfitData } = require('./clientOutfit.js');
const db = require('../db/index.js');

const app = express();
const PORT = 8080 || process.env.PORT;
// const URL = 'https://app-hrsei-api.herokuapp.com/api/fec2/hr-sfo';
// const HEADERS = { headers: { Authorization: GH_TOKEN } };

// app.use(express.static('./client'));
app.use(express.json());
app.use(cors());

app.get('/products/:id', (req, res) => {
  const { id } = req.params;
  db.getItemInfo(id, (err, response) => {
    if (err) {
      res.status(400).send('error');
    } else {
      res.status(200).json(response);
    }
  });
});

app.get('/products/:id/styles', (req, res) => {
  const { id } = req.params;
  db.getStyleInfo(id, (err, response) => {
    if (err) {
      res.status(400).send('error');
    } else {
      res.status(200).json(response);
    }
  });
});

app.get('/products/:id/related', (req, res) => {
  const { id } = req.params;
  db.getRelatedInfo(id, (err, response) => {
    if (err) {
      res.status(400).send('error');
    } else {
      res.status(200).json(response);
    }
  });
});

app.listen(PORT, () => {
  console.log('Server listening well on port:', `${PORT}`);
});
