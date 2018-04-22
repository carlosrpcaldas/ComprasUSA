//
//  TableViewController.swift
//  ComprasUSA
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        label.text = "Sem filmes"
        label.textAlignment = .center
        label.textColor = .white
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem =  UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }

    
    
}

