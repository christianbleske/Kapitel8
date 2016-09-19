//
//  ViewController.swift
//  CoreDataBspSW
//
//  Created by Christian Bleske on 23.10.14.
//  Copyright (c) 2014 Christian Bleske. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var nachname: UITextField!
    @IBOutlet weak var vorname: UITextField!
    @IBOutlet weak var strasse: UITextField!
    @IBOutlet weak var plz: UITextField!
    @IBOutlet weak var ort: UITextField!
     
   /* lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }() */
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func speichernPressed(_ sender: AnyObject) {
        writeData()
    }

    @IBAction func ladenPressed(_ sender: AnyObject) {
        loadData()
    }
    
    func writeData() {
        let kontakt = NSEntityDescription.insertNewObject(forEntityName: "Kontakte", into: self.managedObjectContext!) as! Kontakte
        kontakt.vorname = vorname.text!
        kontakt.nachname = nachname.text!
        kontakt.strasse = strasse.text!
        kontakt.plz = plz.text!
        kontakt.ort = ort.text!
        do {
            try managedObjectContext?.save()
        } catch _ {
        }
        
        showAlertViewWithTitle("Hinweis", message: "Datensatz wurde gespeichert!")

        vorname.text = ""
        nachname.text = ""
        strasse.text = ""
        plz.text = ""
        ort.text = ""
    }
    
    func loadData() {
        let fetchRequest = NSFetchRequest<Kontakte>(entityName: "Kontakte") //ALT = NSFetchRequest(entityName: "Kontakte")
        
        let predicate = NSPredicate(format: "nachname contains %@", nachname.text!)
        fetchRequest.predicate = predicate
        
        var fetchResults:[Kontakte] = []
        do {
                try fetchResults = managedObjectContext!.fetch(fetchRequest) 
                if (fetchResults.count > 0) {
                    nachname.text = fetchResults[0].nachname
                    vorname.text = fetchResults[0].vorname
                    strasse.text = fetchResults[0].strasse
                    plz.text = fetchResults[0].plz
                    ort.text = fetchResults[0].ort
                } else {
                    showAlertViewWithTitle("Hinweis", message: "Datensatz nicht gefunden!")
                }
            
        } catch {
                showAlertViewWithTitle("Fehler", message: "Bei der Verarbeitung ist ein Fehler aufgetreten!")
        }

    }
    
    func showAlertViewWithTitle(_ title:String, message:String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ...
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
        
    }

}

