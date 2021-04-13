const mongoose = require('mongoose');

const recorderSchema = mongoose.Schema({
  records: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Record',
    },
  ],
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
});

const Recorder = mongoose.model('Recorder', recorderSchema);

module.exports = Recorder;
