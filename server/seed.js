const faker = require('faker');

const Record = require('./models/record');

const getRandomInRange = (min, max) =>
  Math.floor(Math.random() * (max - min) + min);

const genders = ['M', 'F', 'O'];
const getRandomGender = () => genders[getRandomInRange(0, 3)];

const addRecords = async () => {
  const num = await Record.countDocuments();
  if (num >= 100) return;

  const records = [];
  for (let i = 0; i < 100; ++i) {
    records.push(
      new Record({
        name: faker.name.findName(),
        phone: faker.phone.phoneNumber('##########'),
        dob: faker.date.between('1/1/1990', '1/1/2015'),
        gender: getRandomGender(),
        vaccinated: Math.round(Math.random()),
        info: faker.lorem.paragraph(),
        oxygen: getRandomInRange(90, 101),
        pulse: getRandomInRange(50, 101),
        location: {
          type: 'Point',
          coordinates: [faker.address.longitude(), faker.address.latitude()],
        },
      })
    );
  }
  await Record.insertMany(records);
  console.log('Records added');
};

(async () => {
  await addRecords();
})();
