const express = require('express');
const app = express();
const mongoose = require('mongoose');
const cors = require('cors');

const PORT = 4000,
  MONGO_URL = `mongodb://localhost/smart-pulseox`;

mongoose.connect(MONGO_URL, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true,
  useFindAndModify: false,
});

app.use(
  cors({
    origin: 'http://localhost:3000',
    credentials: true,
  })
);

app.use(express.json());

require('./models/record');
require('./models/recorder');

// Add a new record
app.post('/', (req, res) => {
  console.log('post');
  res.send({
    data: 'Successful',
    error: null,
  });
});

// Fetch records based on query
app.get('/', (req, res) => {
  console.log('get');
  res.json({
    records: [],
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Up at http://localhost:${PORT}`);
});
