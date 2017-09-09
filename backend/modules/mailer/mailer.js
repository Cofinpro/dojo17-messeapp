const mail = require('sendmail')();
const EmailTemplate = require('email-templates').EmailTemplate;
var path = require('path');
var fs = require('fs');
var _ = require('lodash');

const templateFiles = ['standard', 'boarding', 'dhbw', 'exam', 'internship', 'student'];

const sendResponse = function(dataObject) {
    let templateIndex = false;
    if (dataObject.boarding) templateIndex = 1;
    else if (!_.isNumber(templateIndex) && dataObject.dhbw) templateIndex = 2;
    else if (!_.isNumber(templateIndex) && dataObject.exam) templateIndex = 3;
    else if (!_.isNumber(templateIndex) && dataObject.internship) templateIndex = 4;
    else if (!_.isNumber(templateIndex) && dataObject.student) templateIndex = 5;
    else templateIndex = 0;
    renderTemplate(dataObject, global.config.subjectResponse, 'response/'+templateFiles[templateIndex]);
}

const sendExport = function(dataObject) {
    renderTemplate(dataObject, global.config.subjectExport, 'export');
}

const renderTemplate = function(dataObject, subject, templateName) {
    const templateDir = path.join(__dirname, 'templates', templateName);
    const template = new EmailTemplate(templateDir);
    const exportData = templateName == 'export' ? true : false; 

    template.render(dataObject, (err, result)=> {
        if (err) throw err;
        createMailRequestAndSend(dataObject.email, subject, result.html, exportData);
    });
}

const createMailRequestAndSend = function(receiver, subject, content, exportData) {
    let mailOptions = {
        from: global.config.fromMail,
        to: receiver,
        subject: subject,
        html: content
    }
    if (exportData) mailOptions.attachments = [{ path: './export/data.xlsx' }];
    
    mail(mailOptions, ()=> { console.log('done'); });
}

module.exports.sendResponse = sendResponse;
module.exports.sendExport = sendExport;