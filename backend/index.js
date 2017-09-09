const express = require('express');
const fs = require('fs');
const cors = require('cors')
const bodyParser = require('body-parser');
const repo = require('./modules/repository')
const checkIncoming = require('./modules/checkIncomingData');
const validator = require('./modules/validator');
const exporter =  require('./modules/jsonToXls');
//const sec = require('./modules/security-oauth');
const mailer = require('./modules/mailer/mailer.js');

const app = express();
app.use(bodyParser.json());
app.use(cors());
global.config = JSON.parse(fs.readFileSync(__dirname + '/../config.json', 'utf8'));
//sec.securityConfiguration(app);


const server = app.listen(3000, function () {
    console.log('Server läuft ');
});

app.get('/', (req, res)=> {
    res.send('What can i do with the Gartenschuh');
});

// Get all entries
// params:
app.get('/contact', (req, res)=> {
    repo.getAllContacts((err, post) => {
        if (err) res.send(err)
        res.send(post);
    })
});

// Add new entry to database
// params: helpers/dummy-object.json
app.post('/contact', (req, res)=> {
    const data = req.body;
    let valid = true;

    if (!checkIncoming.isValid(data) || !validator.validateData(data)) valid = false;
    if (valid) {
        repo.createContact(data).then(
            (object) => {
                res.send(object);
            },
            (err) => res.send(err)
        );
    }
    else res.send("data invalid");
});

app.put('/contact', (req, res) => {
    const data = req.body;
    let valid = true;

    if (!checkIncoming.isValid(data.object) || !validator.validateData(data.object)) valid = false;
    if (valid) {
        repo.updateContact(data.id, data.object, (err, post) => {
            mailer.sendResponse(post);
            res.send(post);
        });
    }
    else res.send("data invalid")
});

// Export data and provide as XLS as download
// params:
app.get('/downloadExport', (req, res)=> {
    repo.getAllContacts((err, contactArray) => {
        path = exporter.JsonToXls(contactArray);

        file = fs.readFileSync(path, 'binary');
        stat = fs.statSync(path);

        res.setHeader('Content-Length', stat.size);
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        res.setHeader('Content-Disposition', 'attachment; filename=contacts.xlsx');
        res.write(file, 'binary');
        res.end();
    });
});

// Generate export and send per mail
app.get('/sendExport', (req, res) => {
    res.send('mail raus');
    dataObject = {};
    dataObject.email = global.config.exportMail;
    mailer.sendExport(dataObject);
});
