var express = require('express');
var bodyParser = require('body-parser');
var app = express();

app.post('/', (req, res)=> {
    console.log(req.body.name);
});

app.get('/newentry', (req, res) => {
    res.send('NEUER EINTRAG WURDE GEMACHT');
});

app.listen(3000, function () {
  console.log('mist backend läuft...');
});