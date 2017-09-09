const mail = require('sendmail')();

const send = function(sender, receiver, subject, body, callback) {
    sendmail = (sender, receiver, subject, body, callback) => {
        mail({
           from: sender,
           to: receiver,
           subject: subject,
           content: body
       }, callback)
    }
}

const renderTemplate = function() {
    var EmailTemplate = require('email-templates').EmailTemplate
    var path = require('path')
    
    var templateDir = path.join(__dirname, 'templates', 'newsletter')
    
    var newsletter = new EmailTemplate(templateDir)
    var user = {name: 'Joe', pasta: 'spaghetti'}
    newsletter.render(user, function (err, result) {
      send('hans@hans.de', 'julian.reichwein@cofinpro.de', 'Yoo', result.html, ()=> {
        console.log('mail send');
      });
    });
}

