var mongo = require('mongodb');
var mg = require('mongoose');


mg.connect('mongodb://10.59.1.98:27017/messeapp');

var contactSchema = new mg.Schema({
    salutation: { type: String, required: true },
    firstname: { type: String, required: true },
    name: { type: String, required: true },

    university: String,
    course: String,
    graduation: String,
    graduationDate: Date,

    email: { type: String, unique: true, required: true },
    telephone: Number,

    internship: { type: Boolean, required: true },
    exam: { type: Boolean, required: true },
    student: { type: Boolean, required: true },
    dhbw: { type: Boolean, required: true },
    boarding: { type: Boolean, required: true },

    rating: { type: Number, min: 0, max: 5 },
    comment: String,
    department: String,

    timestamp: { type: Date, default: Date.now }
});

var contactRepo = mg.model('Contact', contactSchema);
contactRepo.collection.deleteMany({});

getAllContacts = (callback) => {
    contactRepo.find(callback);
}

createContact = (contact) => {
    return contactRepo.create(contact);
}

updateContact = (id, contact, callback) => {
    return contactRepo.findByIdAndUpdate(id, contact, callback);
}

module.exports.getAllContacts = getAllContacts;
module.exports.createContact = createContact;
module.exports.updateContact = updateContact;