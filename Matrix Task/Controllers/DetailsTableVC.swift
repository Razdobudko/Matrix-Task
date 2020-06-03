//
//  DetailsTableVC.swift
//  Matrix Task
//
//  Created by Veranika Razdabudzka on 6/1/20.
//  Copyright © 2020 Veranika Razdabudzka. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class DetailsTableVC: UITableViewController {
    
    static func createDetailsTableVC() -> DetailsTableVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsTableVC = storyboard.instantiateViewController(identifier: "DetailsTableVC") as! DetailsTableVC
        return detailsTableVC
    }
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var miniView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameTaskTF: UITextField!
    @IBOutlet weak var taskTV: UITextView!
    @IBOutlet weak var dataPickerTF: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var classes = ["", "Do First", "Schedule", "Delegate", "Delete"]
    
    var doFirstTask: TaskDoFirst?
    var scheduleTask: TaskSchedule?
    var delegateTask: TaskDelegate?
    var deleteTask: TaskDelete?
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        label.text = "Select section"
        
        saveBtn.isEnabled = false
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        nameTaskTF.delegate = self
        
        editTasks()
        configureDatePicker()
        
        nameTaskTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
//MARK: - configure saveBtn
    
    @objc private func textFieldChanged() {
        if nameTaskTF.text?.isEmpty == false {
            saveBtn.isEnabled = true
        }else {
            saveBtn.isEnabled = false
        }
    }
    
//MARK: - Action
    
    @IBAction func clickSaveBtn(_ sender: Any) {
        configureTask()
        
        UserNotificationManager.shared.localNotification(title: "Task Reminder", body: "Check the Task List", date: datePicker.date)
        
        if label.text == "Select section" {
                   let alert = UIAlertController(title: "Select section", message: nil, preferredStyle: .alert)
                   let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alert.addAction(alertOk)
                   present(alert, animated: true, completion: nil)
        } else {
             dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func clickCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//MARK: - DatePicker
    
    private func configureDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(clickDoneButton))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(clickCancelButton))
        toolBar.setItems([doneButton, cancelButton], animated: true)
        dataPickerTF.inputAccessoryView = toolBar
        dataPickerTF.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
    }
    
    @objc private func clickDoneButton () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        dataPickerTF.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func clickCancelButton () {
        view.endEditing(true)
    }
    
//MARK: - NEW_TASK
    
    private func configureTask() {
        
        if label.text == "Do First" {
            guard nameTaskTF.text != nil && nameTaskTF.text != "" else {return}
            let newTask = TaskDoFirst()
            newTask.name = nameTaskTF.text!
            newTask.task = taskTV.text
            newTask.data = dataPickerTF.text
            
            if doFirstTask != nil{
                try! realm.write{
                    doFirstTask?.name = newTask.name
                    doFirstTask?.task = newTask.task
                    doFirstTask?.data = newTask.data
                }
            } else {
                RealmTaskDoFirst.save(newTask)
            }
        }
        
        if label.text == "Schedule" {
            guard nameTaskTF.text != nil && nameTaskTF.text != "" else {return}
            let newTask = TaskSchedule()
            newTask.name = nameTaskTF.text!
            newTask.task = taskTV.text
            newTask.data = dataPickerTF.text
            
            if scheduleTask != nil{
                try! realm.write{
                    scheduleTask?.name = newTask.name
                    scheduleTask?.task = newTask.task
                    scheduleTask?.data = newTask.data
                }
            } else {
                RealmTaskSchedule.save(newTask)
            }
        }
        
        if label.text == "Delegate" {
            guard nameTaskTF.text != nil && nameTaskTF.text != "" else {return}
            let newTask = TaskDelegate()
            newTask.name = nameTaskTF.text!
            newTask.task = taskTV.text
            newTask.data = dataPickerTF.text
            
            if delegateTask != nil{
                try! realm.write{
                    delegateTask?.name = newTask.name
                    delegateTask?.task = newTask.task
                    delegateTask?.data = newTask.data
                }
            } else {
                RealmTaskDelegate.save(newTask)
            }
        }
        
        if label.text == "Delete" {
            guard nameTaskTF.text != nil && nameTaskTF.text != "" else {return}
            let newTask = TaskDelete()
            newTask.name = nameTaskTF.text!
            newTask.task = taskTV.text
            newTask.data = dataPickerTF.text
            
            if deleteTask != nil{
                try! realm.write{
                    deleteTask?.name = newTask.name
                    deleteTask?.task = newTask.task
                    deleteTask?.data = newTask.data
                }
            } else {
                RealmTaskDelete.save(newTask)
            }
        }
    }
    
// MARK: - EDIT_TASK
    
    private func editTasks() {
        if doFirstTask != nil {
            title = "Details"
            label.text = "Do First"
            miniView.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
            saveBtn.isEnabled = true
            nameTaskTF.text = doFirstTask?.name
            taskTV.text = doFirstTask?.task
            dataPickerTF.text = doFirstTask?.data
        }
        
        if scheduleTask != nil {
            title = "Details"
            label.text = "Schedule"
            miniView.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.3490196078, blue: 0.7137254902, alpha: 1)
            saveBtn.isEnabled = true
            nameTaskTF.text = scheduleTask?.name
            taskTV.text = scheduleTask?.task
            dataPickerTF.text = scheduleTask?.data
        }
        
        if delegateTask != nil {
            title = "Details"
            label.text = "Delegate"
            miniView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.4745098039, blue: 0.2078431373, alpha: 1)
            saveBtn.isEnabled = true
            nameTaskTF.text = delegateTask?.name
            taskTV.text = delegateTask?.task
            dataPickerTF.text = delegateTask?.data
        }
        
        if deleteTask != nil {
            title = "Details"
            label.text = "Delete"
            miniView.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7607843137, blue: 0.5058823529, alpha: 1)
            saveBtn.isEnabled = true
            nameTaskTF.text = deleteTask?.name
            taskTV.text = deleteTask?.task
            dataPickerTF.text = deleteTask?.data
        }
    }
}

//MARK:- extension_PickerView

extension DetailsTableVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classes.count
    }
    
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = classes[row]
        switch row {
        case 1:
            self.miniView.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        case 2:
            self.miniView.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.3490196078, blue: 0.7137254902, alpha: 1)
        case 3:
            self.miniView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.4745098039, blue: 0.2078431373, alpha: 1)
        case 4:
            self.miniView.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7607843137, blue: 0.5058823529, alpha: 1)
        default:
            self.miniView.backgroundColor = .clear
            self.label.text = "Select section"
        }
    }
}

//MARK:- extension_PickerView

extension DetailsTableVC: UITextFieldDelegate {    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTaskTF.becomeFirstResponder()
        nameTaskTF.resignFirstResponder()
        return true
    }
}

