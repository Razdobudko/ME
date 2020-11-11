//
//  DetailsTableViewController.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import UIKit
import RealmSwift

@available(iOS 13.4, *)
class DetailsTableViewController: UITableViewController {
    
    static func createDetailsTableVC() -> DetailsTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsTableVC = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as! DetailsTableViewController
        return detailsTableVC
    }
        
    @IBOutlet weak var sectionLbl: UILabel!
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var noteTV: UITextView!
    
    
    @IBOutlet weak var doNowBtn: CustomBtn!
    @IBOutlet weak var scheduleBtn: CustomBtn!
    @IBOutlet weak var delegateBtn: CustomBtn!
    @IBOutlet weak var deleteBtn: CustomBtn!
    
    let datePicker = UIDatePicker()
    
    var doNowTask: DoNowTask?
    var scheduleTask: ScheduleTask?
    var delegateTask: DelegateTask?
    var deleteTask: DeleteTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.delegate = self
        noteTV.delegate = self
        editTasks()
        configureDatePicker()        
    }
    
    // MARK: - Data Manipulation Methods
        
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func alertController(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func configureDatePicker() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        
        toolBar.layer.cornerRadius = 5.0
        toolBar.layer.borderWidth = 3.0
        toolBar.layer.borderColor = #colorLiteral(red: 0.7934994102, green: 0.6018143296, blue: 0.5339533687, alpha: 1)
        toolBar.barTintColor = #colorLiteral(red: 0.1407629848, green: 0.08019874245, blue: 0.05889878422, alpha: 1)
        
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnPressed))
        doneBtn.tintColor = .white
        
        let closeBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(closeBtnPressed))
        closeBtn.tintColor = .white
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([doneBtn,flexibleSpace,closeBtn], animated: true)

        
            datePicker.frame = CGRect(x: 50, y: 50, width: view.frame.size.width, height: 150.0)
            datePicker.backgroundColor = #colorLiteral(red: 0.7934994102, green: 0.6018143296, blue: 0.5339533687, alpha: 1)
        datePicker.tintColor = .black
        
        dateTF.inputAccessoryView = toolBar
        dateTF.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
    }
    
    @objc private func doneBtnPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateTF.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func closeBtnPressed() {
        view.endEditing(true)
    }
    
    // MARK: - Action Methods
    @IBAction func selectionBtnPressed(_ sender: UIButton) {
        switch sender {
        case doNowBtn:
            return sectionLbl.text = NSLocalizedString("DO IT NOW", comment: "")
        case scheduleBtn:
            return sectionLbl.text = NSLocalizedString("PLAN IT", comment: "")
        case delegateBtn:
            return sectionLbl.text = NSLocalizedString("DELEGATE", comment: "")
        case deleteBtn:
            return sectionLbl.text = NSLocalizedString("DROP IT", comment: "")
        default:
            break
        }
    }
        
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        configureTask()
        
        UserNotificationManager.shared.localNotification(title: NSLocalizedString("TASK REMINDER", comment: ""), body: NSLocalizedString("CHECK", comment: ""), date: datePicker.date)
        
        guard titleTF.text != nil && titleTF.text != "" else {return alertController(NSLocalizedString("TITLE", comment: ""), message: "")}
        
        if sectionLbl.text == NSLocalizedString("SELECTED SECTION", comment: "") {
            alertController(NSLocalizedString("SELECTED SECTION_Alert", comment: ""), message: "")
        }else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods Tasks
    private func configureTask() {
        switch sectionLbl.text {
        case NSLocalizedString("DO IT NOW", comment: ""):
            let newDoNowTask = DoNowTask()
            newDoNowTask.name = titleTF.text!
            newDoNowTask.note = noteTV.text
            newDoNowTask.date = dateTF.text
            
            if doNowTask != nil {
                try! realm.write{
                    doNowTask?.name = newDoNowTask.name
                    doNowTask?.note = newDoNowTask.note
                    doNowTask?.date = newDoNowTask.date
                }
            } else {
                SaveDoNowTask.save(newDoNowTask)
            }
        case NSLocalizedString("PLAN IT", comment: ""):
            let newScheduleTask = ScheduleTask()
            newScheduleTask.name = titleTF.text!
            newScheduleTask.note = noteTV.text
            newScheduleTask.date = dateTF.text
            
            if scheduleTask != nil {
                try! realm.write{
                    scheduleTask?.name = newScheduleTask.name
                    scheduleTask?.note = newScheduleTask.note
                    scheduleTask?.date = newScheduleTask.date
                }
            } else {
                SaveSchedule.save(newScheduleTask)
            }
        case NSLocalizedString("DELEGATE", comment: ""):
            let newDelegateTask = DelegateTask()
            newDelegateTask.name = titleTF.text!
            newDelegateTask.note = noteTV.text
            newDelegateTask.date = dateTF.text
            
            if delegateTask != nil {
                try! realm.write{
                    delegateTask?.name = newDelegateTask.name
                    delegateTask?.note = newDelegateTask.note
                    delegateTask?.date = newDelegateTask.date
                }
            } else {
                SaveDelegate.save(newDelegateTask)
            }
        case NSLocalizedString("DROP IT", comment: ""):
            let newDeleteTask = DeleteTask()
            newDeleteTask.name = titleTF.text!
            newDeleteTask.note = noteTV.text
            newDeleteTask.date = dateTF.text
            
            if deleteTask != nil {
                try! realm.write{
                    deleteTask?.name = newDeleteTask.name
                    deleteTask?.note = newDeleteTask.note
                    deleteTask?.date = newDeleteTask.date
                }
            } else {
                SaveDelete.save(newDeleteTask)
            }
        default:
            break
        }
    }
    
    private func editTasks() {
        if doNowTask != nil {
            title = NSLocalizedString("EDIT_TASK", comment: "")
            sectionLbl.text = NSLocalizedString("DO IT NOW", comment: "")
            titleTF.text = doNowTask?.name
            noteTV.text = doNowTask?.note
            dateTF.text = doNowTask?.date
        }
        if scheduleTask != nil {
            title = NSLocalizedString("EDIT_TASK", comment: "")
            sectionLbl.text = NSLocalizedString("PLAN IT", comment: "")
            titleTF.text = scheduleTask?.name
            noteTV.text = scheduleTask?.note
            dateTF.text = scheduleTask?.date
        }
        if delegateTask != nil {
            title = NSLocalizedString("EDIT_TASK", comment: "")
            sectionLbl.text = NSLocalizedString("DELEGATE", comment: "")
            titleTF.text = delegateTask?.name
            noteTV.text = delegateTask?.note
            dateTF.text = delegateTask?.date
        }
        if deleteTask != nil {
            title = NSLocalizedString("EDIT_TASK", comment: "")
            sectionLbl.text = NSLocalizedString("DROP IT", comment: "")
            titleTF.text = deleteTask?.name
            noteTV.text = deleteTask?.note
            dateTF.text = deleteTask?.date
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let tableView = view as? UITableViewHeaderFooterView else { return }
        tableView.textLabel?.textColor = UIColor.white
    }
}

@available(iOS 13.4, *)
extension DetailsTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTF.becomeFirstResponder()
        titleTF.resignFirstResponder()
        return true
    }
}

@available(iOS 13.4, *)
extension DetailsTableViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            noteTV.resignFirstResponder()
            return false
        }
        return true
    }
}

