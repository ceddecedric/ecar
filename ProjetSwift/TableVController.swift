//
//  TableVController.swift
//  ProjetSwift
//
//  Created by Mac OS X on 16/01/2017.
//  Copyright © 2017 Mac OS X. All rights reserved.
//

import UIKit
import  CoreData

class TableVController: UITableViewController, UIGestureRecognizerDelegate {
    
    // UITableView var connected with the controller
    @IBOutlet weak var tblv: UITableView!
    
    // variables declaration
    var position = [Positions]()
    
    var transfertPersonne: Positions?
    
    var name : String!
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding long press gesture parameters on the viewDidload
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TableVController.longPressGesture(_:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.tblv.addGestureRecognizer(longPressGesture)

    }
    
    // function called when the view will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // getting data from the coreData and add the resultin the variable position of type array
        do {
                let results = try managedContext.fetch(Positions.fetchRequest())
            
                position = results as! [Positions]
            
            } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // function defined action when the long press on cell is activated
    
    @IBAction func longPressGesture (_ longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            
            if let indexPath = tblv.indexPathForRow(at: touchPoint) {
                
                //make an alert when user want to delete an element
                let alert = UIAlertController(title: "Delete", message: "Delete this position", preferredStyle: UIAlertControllerStyle.alert)
                
                //action on delete button press
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: {(UIAlertAction)in
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    let managedContext = appDelegate.persistentContainer.viewContext
                    
                    let element = self.position[indexPath.row]
                   
                    //delete the managedObject of the indexPath row
                    managedContext.delete(element)
                                        
                    do {
                        // save the new state of the managed context
                        try managedContext.save()
                        self.position.removeAll()
                        let results = try managedContext.fetch(Positions.fetchRequest())

                        self.position = results as! [Positions]
                        
                    } catch let error as NSError {
                        print ("Could not fetch \(error), \(error.userInfo)")
                    }
                    
                    self.tblv.reloadData()
                   
                   }
                ))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(UIAlertAction)in
                   
                   } ))
                
                   self.present(alert,animated: true, completion: nil)
           
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
               return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of row returned
      
        return position.count
    }

    //Affects data in cells with the identifier myCell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        let posi = position[indexPath.row]
        
        cell!.textLabel!.text = posi.value(forKey: "name") as? String
        
        cell!.tag = indexPath.row
        
        return cell!
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // prepare a naviation of the data of cell to detailView perform by segue "detail"
        
        let path = self.tblv.indexPathForSelectedRow!
        
        let posi = position[path.row]
        
        if (segue.identifier == "detail"){
            
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.lenome = posi.value(forKey: "name") as? String

            detailVC.lalatitudee = posi.value(forKey: "latitude") as? String
            detailVC.lalongitudee = posi.value(forKey: "longitude") as? String
            detailVC.lalititudee = posi.value(forKey: "altitude") as? String
            detailVC.lecommente = posi.value(forKey: "comment") as? String
            
        }
    }
}
