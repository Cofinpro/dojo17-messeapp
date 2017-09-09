const mail = require('sendmail')();
const EmailTemplate = require('email-templates').EmailTemplate;
var path = require('path');
var fs = require('fs');


const sendResponse = function(dataObject) {
    renderTemplate(dataObject, global.config.subjectResponse, 'response');
}

const sendExport = function(dataObject) {
    renderTemplate(dataObject, global.config.subjectExport, 'export');
}

const renderTemplate = function(dataObject, subject, templateName) {  
    const templateDir = path.join(__dirname, 'templates', templateName);
    const template = new EmailTemplate(templateDir);
    const exportData = templateName == 'export' ? true : false; 

    console.log(dataObject);

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