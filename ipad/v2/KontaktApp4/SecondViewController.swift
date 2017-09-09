//
//  SecondViewController.swift
//  KontaktApp4
//
//  Created by Daniel Corak on 08.09.17.
//  Copyright © 2017 Daniel Corak. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    // ### Buttons ###
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // ### Textfields ###
    
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
    
    let jsonFileHandler: JsonFileHandler = JsonFileHandler()
    
    var error : NSError? = nil
    
    @IBAction func saveForm(_ sender: Any) {
        
        do{
            
            
            
            let newContact = Contact(fileId: UUID().uuidString, id:nil, salutation: salutationTF.text!, firstname: firstnameTF.text!, name: nameTF.text!, university: universityTF.text!, course: courseTF.text!, graduation: graduationTF.text!, graduationDate: graduationDateTF.text!, email: emailTF.text!, telephone: telephoneTF.text!, internship: internshipSwitch.isOn, exam: examSwitch.isOn, student: studentSwitch.isOn, dhbw: dhbwSwitch.isOn, boarding: boardingSwitch.isOn, rating: 0, comment: "", department: "", timestamp: Date())
            
            
            if (isValid(contact: newContact)){
                try jsonFileHandler.saveData(contact: newContact);
                
                try jsonFileHandler.printData()
                
                reset()
            }
        } catch let err as NSError {
            print(err.localizedDescription)
            error = err;
            reset()
        }
        
        
    }
    
    
    @IBAction func resetForm(_ sender: Any) {
        
        reset()
    }
    
    
    func isValid(contact:Contact) -> Bool{
        if (contact.email.isEmpty){
            return false;
        }
        if (contact.firstname.isEmpty){
            return false;
        }
        if (contact.name.isEmpty){
            return false;
        }
        
        
        return true;
    }
    func reset() {
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 20
        resetButton.layer.cornerRadius = 20


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

