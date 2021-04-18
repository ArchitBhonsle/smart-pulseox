const express = require('express');
const app = express();
const mongoose = require('mongoose');
const Record = require('./models/record');
// const cors = require('cors');

const PORT = 4000,
  MONGO_URL = `mongodb://localhost/smart-pulseox`;

mongoose.connect(MONGO_URL, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true,
  useFindAndModify: false,
});

// app.use(
//   cors({
//     origin: 'http://localhost:3000',
//     credentials: true,
//   })
// );

app.use(express.json());

require('./models/record');

require('./seed');

// Add a new record
app.post('/', async (req, res) => {
  try {
    const recordData = req.body.data;
    const record = new Record(recordData);
    console.log(record);
    await record.save();

    res.send({
      data: 'successful',
      error: null,
    });
  } catch (error) {
    res.send({
      data: null,
      error: 'failed',
    });
  }
});

// Fetch records based on query
app.get('/', async (req, res) => {
  try {
    const records = await Record.find({}).sort('-stamp').exec();
    res.json({
      data: records,
      error: null,
    });
  } catch (error) {
    res.send({
      data: null,
      error: 'failed',
    });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 Up at http://localhost:${PORT}`);
});
