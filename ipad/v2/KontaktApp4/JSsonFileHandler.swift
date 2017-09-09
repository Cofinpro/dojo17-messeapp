//
//  JSsonFileHandler.swift
//  CofinproContactApp
//
//  Created by Harald Müller on 08.09.17.
//  Copyright © 2017 Harald Müller. All rights reserved.
//

import Foundation


extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}



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
            "graduationDate" : contact.graduationDate,
            "email" : contact.email,
            "telephone" : contact.telephone,
            
            "internship" : contact.internship,
            "exam" : contact.exam,
            "student" : contact.student,
            "dhbw"  : contact.dhbw,
            "boarding" : contact.boarding,
            
            "rating" : contact.rating,
             "comment" : contact.comment,
            
             "departmentCentral" : contact.departmentCentral,
             "departmentBank" : contact.departmentBank,
             "departmentTechnical" : contact.departmentTechnical,

            
            "timestamp":Formatter.iso8601.string(from: contact.timestamp)];
    }
    
    func fromProps(prop: [String : Any], theFileId: String) -> Contact{
        
        let dateString = prop["timestamp"]as? String ?? ""
        let date = Formatter.iso8601.date(from: "2017-09-09T15:01:53.000Z");
  
        var timestamp1 = Formatter.iso8601.date(from: dateString)
        
        if (timestamp1 == nil){
            timestamp1 = dateFormatter.date(from: dateString)
        }
        
        
        
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
            departmentCentral: prop["departmentCentral"] as? BooleanLiteralType ?? false,
            departmentBank: prop["departmentBank"] as? BooleanLiteralType ?? false,
            departmentTechnical: prop["departmentTechnical"] as? BooleanLiteralType ?? false,
            timestamp: timestamp1!)
        
        

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
    
    enum ContactPostError: Error {
        case invalidURL
        case callError(url: String)
        case noData
    }
    
    
    func makePostCall(contact: Contact) throws {
        let contactsEndpoint: String = "http://10.59.1.104:3000/contact/"
        guard let contactsURL = URL(string: contactsEndpoint) else {
            throw ContactPostError.invalidURL
            
        }
        var contactsUrlRequest = URLRequest(url: contactsURL)
        contactsUrlRequest.httpMethod = "POST"
        contactsUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        contactsUrlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let contactProps = toProps(contact: contact)
        let resultContact: Data
        
        resultContact = try JSONSerialization.data(withJSONObject: contactProps, options: [])
        
        print(try JSONSerialization.data(withJSONObject: contactProps,
                                                  options: .prettyPrinted))
      
        
        contactsUrlRequest.httpBody = resultContact
        
        let session = URLSession.shared
        
        
        let task =  session.dataTask(with: contactsUrlRequest) {
            (data, response, error) in
            
            //            guard error == nil else {
            //                throw  ContactPostError.callError(url: "http://10.59.1.104:3000/contact/")}
            //
            //            guard let responseData = data else {
            //                throw ContactPostError.noData
            //            }
            
            guard error == nil else {
                print("error calling POST on http://10.59.1.104:3000/contact/")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                
//                print(try JSONSerialization.data(withJSONObject: responseData,
//                                                 options: .prettyPrinted))
//                
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                
                var returnedContact = self.fromProps(prop: receivedTodo, theFileId: contact.fileId)
                
                returnedContact.fileId = contact.fileId
                
                try self.saveData(contact: returnedContact)
            } catch let err as NSError {
                print(err)
                print("error parsing response from POST on /todos" )
                return
            }
            
        }
        
        
        task.resume()
    }
    
    
}
