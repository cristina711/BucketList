//
//  ViewController.swift
//  NewBucketList
//
//  Created by Qian Yang on 1/21/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
//    DATABASE 3 . CHANGE to entity same name. use to be ["xxxxxx","xxxxxx","xxxxxx","xxxxxx"]
   
    var items = [BucketListItem] ()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//  DATABASE 1  when everytime i want to talk to my database

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        print("loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
//   BEFORE DATABASE CHANGES         cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    
    }
//    this is for when edit select the row, but this row will be delete when add the accesery button to edit, it will change to accesery button function, but this did select is a func that can tell you which row have been selected
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
//    }
    
    
    
//    this line is after add the accesery button to edit
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    
//    this line is to swip to delete, commit is already tell to swip to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
//        BEFORE DATABASE DELETE FUNC
//        items.remove(at: indexPath.row)
//        tableView.reloadData()
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        } else if segue.identifier == "EditItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
             addItemTableViewController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
//   BEFORE DATABASE CHANGES         addItemTableViewController.item = item
            addItemTableViewController.item = item.text!
            
            
            
//    this is when select a row , go to the next controller, the next controller will prepopulate the text
            addItemTableViewController.indexPath = indexPath
        }
    
}
    
//    DATABASE 2 to fetch all the items when load
    func fetchAllItems() {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
            
            
        }
    }
    
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("I hide but i control cancel button press on top view controller ")
        dismiss(animated: true, completion: nil)
    }
    
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
//        BEFORE DATABASE CHANGES
        
//     if let ip = indexPath{
//        items[ip.row] = text
//
//    } else {
//    items.append(text)
//    }
        
        
        if let ip = indexPath{
            let item = items[ip.row]
            item.text = text
            
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do {
           try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
}

