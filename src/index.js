const express = require('express');
const path = require('path');
const crypto = require('crypto');
const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static('public'));

app.post('/generate', (req, res) => {
  const { account, test } = req.body;
  const password = crypto.randomBytes(12).toString('hex');
  res.json({ account, password });
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../public/index.html'));
});

const server = app.listen(PORT, () => {
  console.log(`App listening at http://localhost:${PORT}`);
});

module.exports = { app, server };
