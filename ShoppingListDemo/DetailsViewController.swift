//
//  DetailsViewController.swift
//  MyShoppingList
//
//  Created by Mohamed El-Alfy on 2/9/15.
//  Copyright (c) 2015 Mohamed El-Alfy. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var itemTxt: UITextField!
    @IBOutlet weak var quantityTxt: UITextField!
    @IBOutlet weak var infoTxt: UITextField!
    
    var item :String!
    var quantity:String!
    var info:String!
    var existingItem : NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if existingItem != nil {
            itemTxt.text = item
            quantityTxt.text = quantity
            infoTxt.text = info
        }
    }

    @IBAction func saveTapped(sender: AnyObject) {
        
        // Referance to our app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Referance to managed object context
        let context = appDelegate.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        
        // Check if Item Existing
        if existingItem != nil {
            
            existingItem.setValue(itemTxt.text as String, forKey: "item")
            existingItem.setValue(quantityTxt.text as String, forKey: "quantity")
            existingItem.setValue(infoTxt.text as String, forKey: "info")
            
        }else{
            
            // Create an instance of our data model and initialize
            var newItem = Model(entity:en! , insertIntoManagedObjectContext:context)
            
            // Map our Properties
            newItem.item = itemTxt.text
            newItem.quantity = quantityTxt.text
            newItem.info = infoTxt.text
            
        }
        
        // Save our Context
        context.save(nil)
        
        // Navigate Back to our Main Table View Controller
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        // Navigate Back to our Main Table View Controller
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
