var mg = require('mongoose');

mg.connect('mongodb://10.10.1.2:27017/messeapp');

var contactSchema = new mg.Schema({
    salutation: { type: mg.Schema.Types.ObjectId, ref: 'Salutation' },

    firstName: { type: String, required: true },
    lastName: { type: String, required: true },

    university: { type: String, required: true },
    course: { type: String, required: true },

    graduation: { type: String, required: true },
    graduation_date: Date,

    email: { type: String, unique: true, required: true },
    telephone: Number,

    interests: [{ type: mg.Schema.Types.ObjectId, ref: 'Interest', required: true }],

    timestamp: { type: Date, default: Date.now }
});

var salutationSchema = new mg.Schema({
    code: { type: String, unique: true, required: true },
    name: { type: String, unique: true, required: true }
})

var interestSchema = new mg.Schema({
    code: { type: String, unique: true, required: true },
    name: { type: String, unique: true, required: true }
})

var ratingSchema = new mg.Schema({
    contact: { type: mg.Schema.Types.ObjectId, ref: 'Contact' },

    rate: { type: Number, min: 1, max: 5, required: true },
    reason: { type: String, required: true }
})

var contactRepo = mg.model('Contact', contactSchema);
var salutationRepo = mg.model('Salutation', salutationSchema);
var interestRepo = mg.model('Interest', interestSchema);
var ratingRepo = mg.model('Rating', ratingSchema);

contactRepo.collection.deleteMany({});
salutationRepo.collection.deleteMany({});
interestRepo.collection.deleteMany({});
ratingRepo.collection.deleteMany({});

salutationRepo.create(
    {"code": "mr", "name": "Herr"},
    {"code": "mrs", "name": "Frau"}
)

interestRepo.create(
    {"code": "internship", "name": "Praktikum"},
    {"code": "exam", "name": "Abschlussarbeit"},
    {"code": "student", "name": "Werkstudent"},
    {"code": "dhbw", "name": "DHBW"},
    {"code": "boarding", "name": "Direkteinstieg"}
)


getAllSalutations = (callback) => {
    salutationRepo.find(callback);
}
getAllInterests = (callback) => {
    interestRepo.find(callback);
}
getAllContacts = (callback) => {
    contactRepo.find(callback).populate('salutation').populate('interests');
}

createContact = function(contact) {
    contactRepo.create(contact, (err, post) => {
        if (err) console.log(err)
    })
}


module.exports.getAllSalutations = getAllSalutations;
module.exports.getAllInterests = getAllInterests;
module.exports.getAllContacts = getAllContacts;

module.exports.createContact = createContact;