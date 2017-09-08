//
//  JSsonFileHandler.swift
//  CofinproContactApp
//
//  Created by Harald Müller on 08.09.17.
//  Copyright © 2017 Harald Müller. All rights reserved.
//

import Foundation


class JsonFileHandler  {
    
    // Speicherort für Kontaktdaten
    var storageFile = "Daten"
    
    
    func saveData(contact: Contact){
        
        let json = writeJson(contact: contact);
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("json")
        
        //print("Dateipfad: \(fileURL.path)")
        
        do {
            // In Datei schreiben
            try json.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
    }
    
    func readData(){
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(storageFile).appendingPathExtension("txt")
        
        var readString = ""
        do {
            // Dateiinhalt lesen
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(storageFile), Error: " + error.localizedDescription)
        }
        print("Gespeicherte Daten: \(readString)")
        
    }
    
    func toProps(contact: Contact) ->[String : Any]{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return [
            "salutation" : contact.salutation,
            "firstname" : contact.firstname,
            "name" : contact.name,
            "university" : contact.university,
            "course" : contact.course,
            "graduation" : contact.graduation,
            "graduation_date" : contact.graduationDate,
            "email" : contact.email,
            "telephone" : contact.telephone,
            
            "internship" : contact.internship,
            "exam" : contact.exam,
            "student" : contact.student,
            "dhbw"  : contact.dhbw,
            "boarding" : contact.boarding,
            
            "rating" : contact.rating,
            "department" : contact.department,
            "comment" : contact.comment,
            
            "timestamp":dateFormatter.string(from: contact.timestamp)];
    }
    
    func fromProps(prop: [String : Any]) -> Contact?{
        let newContact = Contact(
            salutation: (String)prop["salutation"],
            firstname: prop["firstname"],
            name: prop["name"],
            university: prop["university"],
            course: prop["course"],
            graduation: prop["graduation"],
            graduationDate: prop["graduationDate"],
            email: prop["email"],
            telephone: prop["telephone"],
            internship: prop["interest"]["internship"],
            exam: prop["interest"]["exam"],
            student: prop["interest"]["student"],
            dhbw: prop["interest"]["dhbw"],
            boarding: prop["interest"]["boarding"],
            rating: prop["rating"],
            comment: prop["comment"],
            department: prop["department"],
            timestamp: prop["timestamp"])
        
        return newContact
        
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
    
    func writeJson(contact: Contact) -> String {
        let props = toProps(contact: contact)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: props,
                                                      options: .prettyPrinted)
            let s = String(data: jsonData, encoding: String.Encoding.utf8)
            return s!;
        } catch let error {
            print("error converting to json: \(error)")
            return ""
        }
    }
    
}
