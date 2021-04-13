const mongoose = require('mongoose');

const pointSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: ['Point'],
    required: true,
  },
  coordinates: {
    type: [Number],
    required: true,
  },
});

const recordSchema = mongoose.Schema({
  recorder: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Recorder',
  },
  name: {
    type: String,
    required: true,
    trim: true,
  },
  phone: {
    type: String,
    required: true,
    match: /^\d{10}$/,
  },
  dob: {
    type: Date,
    min: new Date('1/1/1990'),
    max: new Date('1/1/2020'),
    index: true,
  },
  gender: {
    type: String,
    required: true,
    trim: true,
    enum: ['M', 'F', 'O'],
    index: true,
  },
  vaccinated: {
    type: Boolean,
    required: true,
    index: true,
  },
  info: {
    type: String,
    required: true,
    trim: true,
  },
  oxygen: {
    type: Number,
    required: true,
    index: true,
  },
  pulse: {
    type: Number,
    required: true,
    index: true,
  },
  location: {
    type: pointSchema,
    index: '2dsphere',
  },
});

const Record = mongoose.model('Record', recordSchema);

module.exports = Record;
