const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const fieldValidator = require('./modules/validator');

const server = app.listen(3000, function () {
    console.log('Server läuft ');
});

app.get('/', (req, res)=> {
    res.send('What can i do with the ');
});

// Add new entry to database
app.post('/add', (req, res)=> {

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
