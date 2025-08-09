const express = require('express');
const path = require('path');
const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static('public'));

app.post('/generate', (req, res) => {
  const { account, length = 12, symbols = false } = req.body;

  const base = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  const extra = '!@#$%^&*()_+[]{}<>?,.';
  const chars = base + (symbols ? extra : '');

  let password = '';
  for (let i = 0; i < Math.min(length, 100); i++) {
    password += chars.charAt(Math.floor(Math.random() * chars.length));
  }

  res.json({ account, password });
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../public/index.html'));
});

const server = app.listen(PORT, '0.0.0.0', () => {
  console.log(`App server listening at http://localhost:${PORT}`);
});

module.exports = { app, server };
