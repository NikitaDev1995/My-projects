//
//  TaskOptionTableViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 29.08.2022.
//

import UIKit

class TasksOptionTableViewController: UITableViewController {
    
    private let idOptionsTasksCell = "idOptionsTasksCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    
    private let headerArray = ["DATE","LESSON","TASK","COLOR"]
    private let cellNameArray = ["Date", "Lesson", "Task", ""]
    
    var hexColorCell = "0433FF"
    
    private var tasksModel = TasksModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Tasks"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTasksCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
    }
    
    @objc private func saveButtonTapped() {
        if tasksModel.tasksDate == nil || tasksModel.tasksTask == "Unknown" || tasksModel.tasksLesson == "Unknown" {
            alertOk(title: "Error", message: "Requered to enter: DATE, LESSON, TASK")
        } else {
            tasksModel.tasksColor = hexColorCell
            RealmManager.shared.saveTasksModel(model: tasksModel)
            tasksModel = TasksModel()
            alertOk(title: "Seccess", message: nil)
            hexColorCell = "0433FF"
            tableView.reloadData()
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTasksCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { [self] numberWeekDay, date in
            tasksModel.tasksDate = date
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson", complition: { [self] (lesson) in
            tasksModel.tasksLesson = lesson
        })
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Name Task", placeholder: "Enter name task", complition: { [self] (tasks) in
            tasksModel.tasksTask = tasks
        })
        case 3: navigationController?.pushViewController(TasksColorTableViewController(), animated: true)
        default:
            print("Tap TasksOptionTableViewController")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}
