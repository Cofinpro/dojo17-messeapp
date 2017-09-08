const express = require('express');
const bodyParser = require('body-parser');
const repo = require('./modules/repository')
const app = express();

app.use(bodyParser.json());


const server = app.listen(3000, function () {
    console.log('Server läuft ');
});

app.get('/', (req, res)=> {
    res.send('What can i do with the ');
});

// Add new entry to database
app.post('/add', (req, res)=> {
    repo.createContact(req.body);
    res.send("done")
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

app.get('/interests', (req, res)=> {
    repo.getAllInterests((err, post) => {
        res.send(post);
    })
});

app.get('/salutations', (req, res)=> {
    repo.getAllSalutations((err, post) => {
        res.send(post);
    })
});

app.get('/contacts', (req, res)=> {
    repo.getAllContacts((err, post) => {
        res.send(post);
    })
});