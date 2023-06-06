# Smart Pulse-Oximeter

As the economy is slowly opening up with the lockdown ending, the chance of outbreaks increases dramatically. Early detection can help stop new outbreaks in their tracks. Our solution will use a pulse oximeter sensor to help in screening people. This is a simple way to check for COVID. “Happy hypoxia” or having low blood oxygen levels but no signs of distress is considered to be an indicator of COVID. We are creating a logging system for people who enter an apartment complex, a restaurant, a mall, etc.

There will be three different sections to the project:
- The pulse oximeter using an Arduino and a MAX30102 sensor. This data will be transferred to a smartphone using HC-05 Bluetooth module.
- The interface on the phone will be an app where the user will also other data. This data will be sent to a server.
- The server will not only make access of data faster and more efficient but also allow further analysis like finding hotspots and severity of the outbreak in a particular and help in identifying other patterns which can help in curbing further spread.

### Project architecture
![architecture](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/7b6d494c-3c50-4fb2-acbb-842d0ee0b583)

### Circuit diagram
![circuit](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/bf5b4fbc-a80e-4619-ba22-089d230c97e0)

### Device assembled
![circuit-real](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/538daa17-59d4-4d17-b647-56ea1822b2d1)

### Device reading the data
![reading](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/d6f5bdfa-3fba-4fc3-afa5-92992967ee99)

### Data entry screen
![app1](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/515a4b8d-33ba-4e21-bba7-b4cd45dfad10)

### Data history screen
![app2](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/366ca900-bc4b-4973-86a6-c1c896368e72)

### Data logged to the database
![log](https://github.com/ArchitBhonsle/smart-pulseox/assets/34616931/6c9423ab-212c-4fd4-ab7f-dfc32d403d2d)

