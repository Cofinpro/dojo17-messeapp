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
        
        let daten = "";
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(storageFile).appendingPathExtension("txt")
        
        //print("Dateipfad: \(fileURL.path)")
        
        do {
            // In Datei schreiben
            try daten.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
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
            
            "interest.internship" : contact.internship,
            "interest.exam" : contact.exam,
            "interest.student" : contact.student,
            "interest.dhbw"  : contact.dhbw,
            "interest.boarding" : contact.boarding,
            
            "rating" : contact.rating,
            "department" : contact.department,
            "comment" : contact.comment];
    }
    
    func fromProps(json: String) -> Contact{
        
        return  Contact();
        
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
        let props = toProps(contact)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: props,
                                                      options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch let error {
            print("error converting to json: \(error)")
            return ""
        }
    }
    
}
