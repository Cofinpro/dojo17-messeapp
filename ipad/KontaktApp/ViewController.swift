//
//  ViewController.swift
//  KontaktApp
//
//  Created by Daniel Corak on 08.09.17.
//  Copyright © 2017 Daniel Corak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Speicherort für Kontaktdaten
    var storageFile = "Daten"
    
    // ### Die Textfelder ###
    
    // Name des Bewerbers
    var name: String = ""
    @IBOutlet weak var nameTF: UITextField!
    
    // Hochschule des Bewerbers
    var hochschule: String = ""
    @IBOutlet weak var hochschuleTF: UITextField!
    
    // E-Mail des Bewerbers
    var email: String = ""
    @IBOutlet weak var emailTF: UITextField!
    
    // Studienrichtung und Semesteranzahl des Bewerbers
    var richtung_anzahl: String = ""
    @IBOutlet weak var richtung_anzahlTF: UITextField!

    // Telefonnummer des Berwerbers
    var telefonnummer: String = ""
    @IBOutlet weak var telefonnummerTF: UITextField!

    // Voraussichtlicher Abschluss und Datum 
    var abschluss_datum: String = ""
    @IBOutlet weak var abschluss_datumTF: UITextField!
    
    // ### Die Checkboxen ###
    
    // Beraterschnuppertage
    var beraterschnuppertage: String = "Nein"
    @IBOutlet weak var beraterschnuppertageSwitch: UISwitch!
    
    // Abschlussarbeit
    var abschlussarbeit: String = "Nein"
    @IBOutlet weak var abschlussarbeitSwitch: UISwitch!
    
    // Praktikum
    var praktikum: String = "Nein"
    @IBOutlet weak var praktikumSwitch: UISwitch!
    
    // Direkteinstieg
    var direkteinstieg: String = "Nein"
    @IBOutlet weak var direkteinstiegSwitch: UISwitch!
    
    @IBAction func finishButton(_ sender: Any) {
    
        print("Daten wurden eingegeben")
        name = nameTF.text!
        hochschule = hochschuleTF.text!
        email = emailTF.text!
        richtung_anzahl = richtung_anzahlTF.text!
        telefonnummer = telefonnummerTF.text!
        abschluss_datum = abschluss_datumTF.text!
        
        if (beraterschnuppertageSwitch.isOn){ beraterschnuppertage = "Ja"
        }
        
        if (abschlussarbeitSwitch.isOn){
            abschlussarbeit = "Ja"
        }
        
        if (praktikumSwitch.isOn){
            praktikum = "Ja"
        }
        
        if (direkteinstiegSwitch.isOn){
            direkteinstieg = "Ja"
        }
        
        readData()
        saveData(daten: name)
    }
    
    
    func saveData(daten: String){
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

