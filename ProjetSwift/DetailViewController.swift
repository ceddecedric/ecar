//
//  DetailViewController.swift
//  ProjetSwift
//
//  Created by Mac OS X on 16/01/2017.
//  Copyright © 2017 Mac OS X. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate {
    
    // labels of detail view
    @IBOutlet weak var lename: UILabel!
    
    @IBOutlet weak var lelal: UILabel!
    
    @IBOutlet weak var lelon: UILabel!
    
    @IBOutlet weak var lal: UILabel!
    
    @IBOutlet weak var lecomm: UILabel!
    
    // variables used to get the data of table view cell perfform by segue "detail"
    var lenome : String!
    var lalatitudee : String!
    var lalongitudee : String!
    var lalititudee : String!
    var lecommente : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // affects the values of variable in the labels text
        
        lename.text = lenome
        lelal.text = lalatitudee
        
        lelon.text = lalongitudee
        lal.text = lalititudee
        lecomm.text = lecommente

        
    }
    
    // Action on press go button
    
    @IBAction func goMap(_ sender: Any) {
        
    }
    
    
    
    
    // Action on press back button
    
    @IBAction func back(_ sender: Any) {
      self.navigationController!.popViewController(animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ViewController
        if (segue.identifier == "goo"){
        controller.lal = Double(lalatitudee)!
        controller.lol = Double(lalongitudee)!
        }
    }
}
