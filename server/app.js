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
    origin: '*',
    credentials: true,
  })
);

app.use(express.json());

app.listen(PORT, () => {
  console.log(`🚀 Up at http://localhost:${PORT}`);
});
