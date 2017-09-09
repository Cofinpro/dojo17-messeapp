const mail = require('sendmail')();
const EmailTemplate = require('email-templates').EmailTemplate;
var path = require('path');

const send = function(receiver) {
    renderTemplate(receiver);
}

const renderTemplate = function(receiver) {    
    const templateDir = path.join(__dirname, 'templates/response');
    
    let responseTemplate = new EmailTemplate(templateDir);
    let user = {name: 'Joe', pasta: 'spaghetti'};
    responseTemplate.render(user, (err, result)=> {
        createMailRequestAndSend(receiver, result.html);
    });
}

const createMailRequestAndSend = function(receiver, content) {
    console.log(content);
    mail({
        from: '#_Karriere<karriere@cofinpro.de>',
        to: receiver,
        subject: 'Danke für dein Interesse an der Cofinpro',
        html: content
    }, ()=> {
        console.log('done');
    });
}

module.exports.sendResponse = send;
