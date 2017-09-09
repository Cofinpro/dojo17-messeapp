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
    
    init() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    
    func saveData(contact: Contact) throws {
        
        let json = toJsonString(contact: contact);
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(contact.fileId).appendingPathExtension("json")
        
        // In Datei schreiben
        try json.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        
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
    
    func fromProps(prop: [String : Any], theFileId: String) -> Contact{
        return Contact(
            fileId: theFileId,
            id:prop["_id"] as? String ?? nil,
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
    
    
    func toJsonString(contact: Contact) -> String {
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
    
    func fromJsonString(fileName: URL, jsonString: String) -> Contact?{
        
        let components = fileName.pathComponents
        
        let filename = components[components.count-1]
        let fileId = filename.components(separatedBy: ".")[0]
        
        
        if let jsonData = loadJson(fileName: fileName){
            return fromProps(prop: jsonData as! [String : Any], theFileId: fileId)
        }else{
            return nil
        }
    }
    
    func loadJson(fileName: URL) -> NSDictionary? {
        
        if let data = NSData(contentsOf: fileName) {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                
                return dictionary
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        print("Error!! Unable to load  \(fileName).json")
        return nil
    }
    
    func listFilesOnDevice() {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func printData() throws{
        
        
        for contact in try getData(){
            
            print("Gespeicherte Daten: \(contact)")
        }
        
        
        
    }
    
    func getData() throws -> [Contact]{
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        var contacts = [Contact]()
        
        let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
        
        for fileNameUrl in directoryContents{
 
            let jsonString = try String(contentsOf: fileNameUrl)
 
            if let contact = fromJsonString(fileName: fileNameUrl, jsonString: jsonString){
                contacts.append(contact)
            }
            
            
        }
        
       contacts = contacts.sorted(by: { $0.timestamp > $1.timestamp })
        
        
        
        return contacts;
    }
    
    func deleteFile(fileId: String) throws{
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(fileId).appendingPathExtension("json")
        
        try FileManager.default.removeItem(at: fileURL)
        
    }
    
    func makeGetCall() {
        // Set up the URL request
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    
    
}
