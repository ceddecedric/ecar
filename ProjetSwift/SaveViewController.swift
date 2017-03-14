//
//  SaveViewController.swift
//  ProjetSwift
//
//  Created by Mac OS X on 16/01/2017.
//  Copyright © 2017 Mac OS X. All rights reserved.
//


// import coreData packages for database manipulation
import UIKit
import CoreData
import MapKit
import CoreLocation

class SaveViewController: UIViewController, CLLocationManagerDelegate {
    
    // Save view labels and textFields and save button connect to SaveViewController
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var altitude: UILabel!
    
    @IBOutlet weak var namee: UITextField!
    
    @IBOutlet weak var comment: UITextView!
    
    @IBOutlet weak var savebouton: UIButton!
    
    // NSManagedObject variable of type array
    var position = [NSManagedObject]()
    
    // variables for location data value
    var mlatitude: String!
    var mlongitude: String!
    var maltitude: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // display location data in save view
        latitude.text = mlatitude
        longitude.text = mlongitude
        altitude.text = maltitude 
   
    }
    
    // save button action function
    
    @IBAction func save(_ sender: Any) {
        
        //Control on empty value in name textField
        if (namee.text == "") {
            let alert = UIAlertController(title: "Error", message: "Enter position's name", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction)in
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else {
        
        // viewContext initialization, values setting and persist in coreData model
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Positions", in: managedContext)
        
        let donnees = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        donnees.setValue(namee.text, forKey: "name")
        donnees.setValue(latitude.text, forKey: "latitude")
        donnees.setValue(longitude.text, forKey: "longitude")
        donnees.setValue(altitude.text, forKey: "altitude")
        donnees.setValue(comment.text, forKey: "comment")
        
        do {
            try managedContext.save()
            position.append(donnees)
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
            
            //make an alert when user save a position
            let alert = UIAlertController(title: "Save", message: "Position saved success!", preferredStyle: UIAlertControllerStyle.alert)
            
            //action on delete button press
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction)in
                
                // return to Maps after saving in coreData
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                
                let nav = storyboard.instantiateViewController(withIdentifier: "root")
                
                UIApplication.shared.keyWindow?.rootViewController = nav
                
            }
            ))
            
            self.present(alert,animated: true, completion: nil)
        
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
