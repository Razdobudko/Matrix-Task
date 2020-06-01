//
//  DelegateVC.swift
//  Matrix Task
//
//  Created by Veranika Razdabudzka on 6/1/20.
//  Copyright © 2020 Veranika Razdabudzka. All rights reserved.
//

import UIKit
import RealmSwift

class DelegateVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks: Results<TaskDelegate>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = realm.objects(TaskDelegate.self)
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}

//MARK:- extension

extension DelegateVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write{
                let task = tasks[indexPath.row]
                realm.delete(task)
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailsTableVC.createDetailsTableVC()
        let task = tasks[indexPath.row]
        detailVC.delegateTask = task
        
        let navController = UINavigationController(rootViewController: detailVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }
}


