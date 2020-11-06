//
//  ScheduleTableVC.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import UIKit
import RealmSwift

class ScheduleVC: SwipeTableVC {
    
    let realm = try! Realm()
    var scheduleTasks: Results<ScheduleTask>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScheduleTasks()
    }
    
    // MARK: - Data Manipulation Methods
    func loadScheduleTasks() {
        scheduleTasks = realm.objects(ScheduleTask.self)
        tableView.reloadData()
    }

// MARK: - Table View Data Sours and Delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleTasks?.count ?? 1
    }
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
        if let scheduleTask = scheduleTasks?[indexPath.row] {
            cell.textLabel?.text = scheduleTask.name
        }
        return cell
    }
        
    override func updateModel(at indexPath: IndexPath) {
        if let taskForDeletion = self.scheduleTasks?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(taskForDeletion)
                }
            } catch  {
                print("Ошибка \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsTableVC = DetailsTableViewController.createDetailsTableVC()
        let taskSchedule = scheduleTasks?[indexPath.row]
        detailsTableVC.scheduleTask = taskSchedule
        
        let navController = UINavigationController(rootViewController: detailsTableVC)
        
        navController.navigationBar.barTintColor = #colorLiteral(red: 0.1904651821, green: 0.1438018084, blue: 0.1223188266, alpha: 1)
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 25) as Any]
        
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }
}
