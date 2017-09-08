//
//  Contact.swift
//  CofinproContactApp
//
//  Created by Harald Müller on 08.09.17.
//  Copyright © 2017 Harald Müller. All rights reserved.
//

import Foundation

struct Contact {
    var salutation = "";
    var firstname = "";
    var name = "";
    var university = "";
    var course = "";
    var graduation = "";
    var graduationDate = "";
    var email = "";
    var telephone = "";
    
    var internship = false;
    var exam = false;
    var student = false;
    var dhbw = false;
    var boarding = false;
    
    var rating = 0;
    var comment = "";
    var department = "";
    
    var timestamp: Date;
}
/*
{
    "salutation": "",
    "first_name": "",
    "name": "",
    "university": "",
    "course": "",
    "graduation": "",
    "graduation_date": "",
    "email": "",
    "telephone": "",
    "interest": {
        "internship": "",
        "exam": "",
        "student": "",
        "dhbw": "",
        "boarding": ""
    },
    "rating": "",
    "comment": "",
    "timestamp": ""
}*/
