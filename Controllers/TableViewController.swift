//
//  TableViewController.swift
//  OrganizeIt
//
//  Created by Jose Domingo on 2018-08-06.
//  Copyright © 2018 Jose Domingo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class TableViewController: UITableViewController{
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = retrieveItems()
        
    }
    
    func retrieveItems() -> [Item]{
        return retrieveItems()
    }
    
}
