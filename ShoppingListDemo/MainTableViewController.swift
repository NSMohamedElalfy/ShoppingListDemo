//
//  MainTableViewController.swift
//  MyShoppingList
//
//  Created by Mohamed El-Alfy on 2/9/15.
//  Copyright (c) 2015 Mohamed El-Alfy. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    var myList:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        
        // Referance to our app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Referance to managed object context
        let context = appDelegate.managedObjectContext!
        
        // Referance to Fetch Request
        let freq = NSFetchRequest(entityName: "List")
        
        // Append Data
        myList = context.executeFetchRequest(freq, error: nil)!
        
        // Reload TableView Data
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        var data : NSManagedObject = myList[indexPath.row] as! NSManagedObject
        cell.textLabel?.text = data.valueForKey("item") as? String
        
        var quantity = data.valueForKey("quantity") as? String
        var info = data.valueForKey("info") as? String
        
        cell.detailTextLabel?.text = "\(quantity!) items - \(info!)"

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Referance to our app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Referance to managed object context
        let context = appDelegate.managedObjectContext!
        
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            context.deleteObject(myList[indexPath.row] as! NSManagedObject)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            var error : NSError?
            
            if !context.save(&error) {
                abort()
            }
        }
        
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "update"{
            var selectedItem:NSManagedObject = myList[self.tableView.indexPathForSelectedRow()!.row]  as! NSManagedObject
            let IVC : DetailsViewController = segue.destinationViewController as! DetailsViewController
            IVC.item = selectedItem.valueForKey("item") as! String
            IVC.quantity = selectedItem.valueForKey("quantity") as! String
            IVC.info = selectedItem.valueForKey("info") as! String
            
            IVC.existingItem = selectedItem
            
        }
        
        
    }
    

}
