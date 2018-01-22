//
//  AddItemTableViewController.swift
//  NewBucketList
//
//  Created by Qian Yang on 1/21/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: NSIndexPath?
//  var item: String?  for editing to prepopulate the text
//    var indexPath: NSIndexPath? is to edit and save but not to save a new one
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
//        this line will have the text send from selected from previous controller prepopulate in this one when view load

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    

    

}
