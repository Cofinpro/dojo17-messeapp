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
    
    let dateFormatter = DateFormatter()
    
    init(_: <#parameters#>) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    
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
        return Contact(
            salutation: prop["salutation"] as? String ?? "",
            firstname: prop["firstname"] as? String ?? "",
            name: prop["name"] as? String ?? "",
            university: prop["university"] as? String ?? "",
            course: prop["course"] as? String ?? "",
            graduation: prop["graduation"] as? String ?? "",
            graduationDate: prop["graduationDate"] as? String ?? "",
            email: prop["email"] as? String ?? "",
            telephone: prop["telephone"] as? String ?? "",
            internship: prop["internship"] as? BooleanLiteralType ?? false,
            exam: prop["exam"] as? BooleanLiteralType ?? false,
            student: prop["student"] as? BooleanLiteralType ?? false,
            dhbw: prop["dhbw"] as? BooleanLiteralType ?? false,
            boarding: prop["boarding"] as? BooleanLiteralType ?? false,
            rating: prop["rating"] as? Int ?? 0,
            comment: prop["comment"] as? String ?? "",
            department: prop["department"] as? String ?? "",
            timestamp: dateFormatter.date(from: prop["timestamp"]as? String ?? "")!)
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
