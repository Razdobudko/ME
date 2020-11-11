//
//  DoNowTableVC.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import UIKit
import RealmSwift

@available(iOS 13.4, *)
class DoNowTableVC: SwipeTableVC {
    
    let realm = try! Realm()
    var doNowTasks: Results<DoNowTask>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDoNowTasks()
    }
    
    // MARK: - Data Manipulation Methods
    
    func loadDoNowTasks() {
        doNowTasks = realm.objects(DoNowTask.self)
        tableView.reloadData()
    }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doNowTasks?.count ?? 1
    }
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
        if let doNowTask = doNowTasks?[indexPath.row] {
            cell.textLabel?.text = doNowTask.name
        }
        return cell
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let taskForDeletion = self.doNowTasks?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(taskForDeletion)
                }
            } catch  {
                print("Error \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsTableVC = DetailsTableViewController.createDetailsTableVC()
        let taskDoNow = doNowTasks?[indexPath.row]
        detailsTableVC.doNowTask = taskDoNow
        
        let navController = UINavigationController(rootViewController: detailsTableVC)
        
        navController.navigationBar.barTintColor = #colorLiteral(red: 0.1904651821, green: 0.1438018084, blue: 0.1223188266, alpha: 1)
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 25) as Any]
        
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }

}

