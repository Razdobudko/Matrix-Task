//
//  DoFirstVC.swift
//  Matrix Task
//
//  Created by Veranika Razdabudzka on 6/1/20.
//  Copyright © 2020 Veranika Razdabudzka. All rights reserved.
//

import UIKit
import RealmSwift

class DoFirstVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: Results<TaskDoFirst>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = realm.objects(TaskDoFirst.self)
        tableView.tableFooterView = UIView()
        tableView.reloadData()        
    }
}
