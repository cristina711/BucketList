//
//  AddItemTableViewControllerDelegate.swift
//  NewBucketList
//
//  Created by Qian Yang on 1/21/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit


protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
