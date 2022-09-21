//
//  TaskEditController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 15.05.2022.
//

import UIKit

class TaskEditController: UITableViewController {

    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    var taskTitles: [TaskPriority: String] = [.normal: "прочие", .important: "Важные"]
    
    
    
    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskTypeLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle?.text = taskText
        taskTypeLabel?.text = taskTitles[taskType]
        if taskStatus == .complited {
            taskStatusSwitch.isOn = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
        let destination = segue.destination as! TaskTypeController
        destination.selectedType = taskType
            destination.doAfterTypeCelected = { [ unowned self] selectedType in
            taskType = selectedType
            taskTypeLabel?.text = taskTitles[taskType]
        }
    }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        let title = taskTitle?.text ?? ""
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ?.complited : .planned
        doAfterEdit?(title, type, status)
        navigationController?.popViewController(animated: true)
    }

}
