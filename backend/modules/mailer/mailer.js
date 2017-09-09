const mail = require('sendmail')();
const EmailTemplate = require('email-templates').EmailTemplate;
var path = require('path');

const sendResponse = function(receiver) {
    renderTemplate(receiver, 'response');
}

const sendExport = function(receiver) {
    renderTemplate('karriere@cofinpro.de', 'Messeinteressenten Excel Export', 'export');
}

const renderTemplate = function(receive, template) {  
    const templateDir = path.join(__dirname, 'templates', template);
    
    let responseTemplate = new EmailTemplate(templateDir);
    responseTemplate.render(user, (err, result)=> {
        createMailRequestAndSend(receiver, 'Kennenlernen der Cofinpro', result.html);
    });
}

const createMailRequestAndSend = function(receiver, subject, content) {
    mail({
        from: '#_Karriere<karriere@cofinpro.de>',
        to: receiver,
        subject: subject,
        html: content,
        attachements: [{
            filename: 'data.xlsx',
            path: './backend/export/'
        }]
    }, ()=> {
        console.log('done');
    });
}

module.exports.sendResponse = sendResponse;
module.exports.sendExport = sendExport;