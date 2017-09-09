var mail = require('sendmail')();

sendmail = (sender, receiver, subject, body, callback) => {
    mail({
       from: sender,
       to: receiver,
       subject: subject,
       content: body
   }, callback)
}

module.exports.sendmail = sendmail;