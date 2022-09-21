//
//  TaskTypeController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 15.05.2022.
//

import UIKit

class TaskTypeController: UITableViewController {

    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    private var taskTypesInformation: [TypeCellDescription] = [(type: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным типом задач. Все важные задачи выводятся в самом верху списка"), (type: .normal, title: "Прочие", description: "Задачи с обычнам приоритетом")]
    
    var selectedType: TaskPriority = .normal
    
    var doAfterTypeCelected: ((TaskPriority) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellTypNib = UINib(nibName: "TaskTypeCell", bundle: nil)
        tableView.register(cellTypNib, forCellReuseIdentifier: "TaskTypeCell")
      
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return taskTypesInformation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        let typeDescription = taskTypesInformation[indexPath.row]
        cell.typeTitle.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = taskTypesInformation[indexPath.row].type
        doAfterTypeCelected?(selectedType)
        navigationController?.popViewController(animated: true)
    }

}
