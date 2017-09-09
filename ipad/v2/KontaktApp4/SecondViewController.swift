//
//  SecondViewController.swift
//  KontaktApp4
//
//  Created by Daniel Corak on 08.09.17.
//  Copyright © 2017 Daniel Corak. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    // ### Textfields
    
    // Salutation of applicant
    var salutation: String = ""
    @IBOutlet weak var salutationTF: UITextField!
    
    // First name of applicant
    var firstname: String = ""
    @IBOutlet weak var firstnameTF: UITextField!
    
    // Last name of applicant
    var name: String = ""
    @IBOutlet weak var nameTF: UITextField!
    
    // Name of the attended university
    var university: String = ""
    @IBOutlet weak var universityTF: UITextField!
    
    // Course of applicant
    var course: String = ""
    @IBOutlet weak var courseTF: UITextField!
    
    // Graduation of applicant
    var graduation: String = ""
    @IBOutlet weak var graduationTF: UITextField!
    
    // Graduation date 
    var graduationDate: String = ""
    @IBOutlet weak var graduationDateTF: UITextField!
    
    // Email of applicant
    var email: String = ""
    @IBOutlet weak var emailTF: UITextField!
    
    // Telephone number of applicant 
    var telephone: String = ""
    @IBOutlet weak var telephoneTF: UITextField!
    
    // ### Checkboxes ###
    
    // Internship
    var internship: Bool = false
    @IBOutlet weak var internshipSwitch: UISwitch!
    
    // Student
    @IBOutlet weak var studentSwitch: UISwitch!
    
    // Exam
    var exam: Bool = false
    @IBOutlet weak var examSwitch: UISwitch!
    
    // DHBW
    var dhbw: Bool = false
    @IBOutlet weak var dhbwSwitch: UISwitch!
    
    // Boarding
    var boarding: Bool = false
    @IBOutlet weak var boardingSwitch: UISwitch!

    
    @IBAction func saveForm(_ sender: Any) {
        
        print("Form was saved")
        saveData(storageFile: "Daten1", daten: "Daniel")
        saveData(storageFile: "Daten2", daten: "Harald")
        saveData(storageFile: "Daten3", daten: "Michael")
        
        listFilesOnDevice()
        readData()
        
        // let newContact = Contact(salutation: salutationTF.text!, firstname: firstnameTF.text!, name: nameTF.text!, university: universityTF.text!, course: courseTF.text!, graduation: graduationTF.text!, graduationDate: graduationTF.text!, email: emailTF.text!, telephone: telephoneTF.text!, internship: internshipSwitch.isOn, exam: examSwitch.isOn, student: studentSwitch.isOn, dhbw: dhbwSwitch.isOn, boarding: boardingSwitch.isOn, rating: <#T##Int#>, comment: <#T##String#>, department: <#T##String#>, timestamp: <#T##Date#>)
        
    }
    
    

    @IBAction func resetForm(_ sender: Any) {
        
        salutationTF.text = ""
        firstnameTF.text = ""
        nameTF.text = ""
        universityTF.text = ""
        courseTF.text = ""
        graduationTF.text = ""
        graduationDateTF.text = ""
        emailTF.text = ""
        telephoneTF.text = ""
        internshipSwitch.setOn(false, animated: true)
        studentSwitch.setOn(false, animated: true)
        examSwitch.setOn(false, animated: true)
        dhbwSwitch.setOn(false, animated: true)
        boardingSwitch.setOn(false, animated: true)
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
    
    func readData(){
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            var readString: String = ""
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            
            for i in 0...directoryContents.count - 1{
            readString = try String(contentsOf: directoryContents[i])
            print("Gespeicherte Daten: \(readString)")
            }

            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    
        
    }
    
    func saveData(storageFile: String, daten: String){
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

