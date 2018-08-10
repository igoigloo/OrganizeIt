//
//  ListNotesTableViewController.swift
//  OrganizeIt
//
//  Created by Jose Domingo on 2018-08-09.
//  Copyright © 2018 Jose Domingo. All rights reserved.
//

import Foundation
import UIKit

class ListNotesTableViewController: UITableViewController {
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
