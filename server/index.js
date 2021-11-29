const express = require('express');
const axios = require('axios');
const cors = require('cors');
// const { GH_TOKEN } = require('../tokens.js');
// const { outfitData } = require('./clientOutfit.js');
const db = require('../db/index.js');

const app = express();
const PORT = 8080 || process.env.PORT;
// const URL = 'https://app-hrsei-api.herokuapp.com/api/fec2/hr-sfo';
// const HEADERS = { headers: { Authorization: GH_TOKEN } };

app.use(express.static('./client'));
app.use(express.json());
app.use(cors());

app.get('/products/', (req, res) => {
  const id = 5;
  db.getItemInfo(id, (err, response) => {
    if (err) {
      console.log('error was here');
      res.status(400).send('error');
    } else {
      res.status(200).json(response);
    }
  });
});

app.get('/test/', (req, res) => {
  const id = 5;
  db.getStyleInfo(id, (err, response) => {
    if (err) {
      console.log('error was here');
      res.status(400).send('error');
    } else {
      res.status(200).json(response);
    }
  });
});

app.get('/related/', (req, res) => {
  const id = 5;
  db.getRelatedInfo(id, (err, response) => {
    if (err) {
      console.log('error was here');
      res.status(400).send('error');
    } else {
      res.status(200).json(response);
    }
  });
});

app.listen(PORT, () => {
  console.log('Server listening well on port:', `${PORT}`);
});
