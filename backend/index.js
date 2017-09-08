const express = require('express');
const bodyParser = require('body-parser');
const checkIncoming = require('./modules/checkIncomingData.js');
const validator = require('./modules/validator.js');

const app = express();
const parser = bodyParser.json();

const server = app.listen(3000, function () {
    console.log('Server läuft ');
});

app.get('/', (req, res)=> {
    res.send('What can i do with the Gartenschuh');
});

// Add new entry to database
// params: helpers/dummy-object.json
app.post('/add', parser, (req, res)=> {
    const data = req.body;
    checkIncoming.isValid(data);
    validator.validateData(data);
});

// Update existing entry
// params: id, [helpers/dummy-object.json]
app.post('/update', (req, res)=> {

});

// Add rating to entry
// params: id, rating
app.post('/rate', (req, res)=> {

});

// Get all entries
// params:
app.post('/getall', (req, res)=> {

});

// Export data
// params:
app.post('/export', (req, res)=> {

});
