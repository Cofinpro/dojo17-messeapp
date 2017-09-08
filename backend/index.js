const express = require('express');
const bodyParser = require('body-parser');
const _ = require('lodash');
const checkIncoming = require('./modules/checkIncomingData.js');

const app = express();

const server = app.listen(3000, function () {
    console.log('Server läuft ');
});

app.get('/', (req, res)=> {
    res.send('What can i do with the ');
});

// Add new entry to database
app.post('/add', (req, res)=> {
    
    checkIncoming.isValid(data); 
});

// Update existing entry
app.post('/update', (req, res)=> {

});

// Add rating to entry
app.post('/rate', (req, res)=> {

});

// Export data
app.post('/export', (req, res)=> {

});