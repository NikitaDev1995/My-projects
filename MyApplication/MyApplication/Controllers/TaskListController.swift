//
//  TaskListControllerTableViewController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 09.05.2022.
//

import UIKit

class TaskListController: UITableViewController {

    
    var taskStorage: TaskStorageProtocol = TaskStorage()
    var tasks: [TaskPriority:[TaskProtocol]] = [:] {
        didSet { for (tasksGroupPriority, tasksGroup) in tasks {
            tasks[tasksGroupPriority] = tasksGroup.sorted { task1, task2 in
                let task1position = taskStatusPosition.firstIndex(of: task1.status) ?? 0
                let task2position = taskStatusPosition.firstIndex(of: task2.status) ?? 0
                return task1position > task2position
            }
        }
            var savingArray: [TaskProtocol] = []
            tasks.forEach { _, value in
                savingArray += value
            }
            taskStorage.saveTask(savingArray)
    }
    }
    
    var sectionsTypesPositions: [TaskPriority] = [.important, .normal]
    var taskStatusPosition: [TaskStatus] = [.complited, .planned]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        
        loadTasks()
    }
    
    func setTasks(_ tasksCollection: [TaskProtocol]) {
        sectionsTypesPositions.forEach{ taskType in
            tasks[taskType] = []
        }
        
        tasksCollection.forEach{ task in
            tasks[task.type]?.append(task)
        }
    }

    private func loadTasks() {
        sectionsTypesPositions.forEach { taskType in
            tasks[taskType] = []
            

        }
        
        taskStorage.loadTask().forEach { task in
            tasks[task.type]?.append(task)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskType = sectionsTypesPositions[section]
        guard let currentTaskType = tasks[taskType] else {
            return 0
        }
        return currentTaskType.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    
    //Кастомная ячейка
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
    let taskType = sectionsTypesPositions[indexPath.section]
    guard let currentTask = tasks[taskType]?[indexPath.row] else {
    return cell
        
    }
    
    cell.title.text = currentTask.title
    cell.symbol.text = getSymbolForTask(with: currentTask.status)
        if currentTask.status == .planned {
            cell.title.textColor = .black
            cell.symbol.textColor = .black
        } else {
            cell.title.textColor = .lightGray
            cell.symbol.textColor = .lightGray
        }
    return cell
    }
    
    //Обработка по нажатию на строку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: IndexPath(arrayLiteral: indexPath.section), animated: true)
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    //Отмечаем задачу как невыполненная по свайпу в право
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let  taskType = sectionsTypesPositions[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else {
            return nil
        }
        
        guard tasks[taskType]![indexPath.row].status == .complited else {
             let actionSwipeInstance = UIContextualAction(style: .normal, title: "Выполненна") { _, _, _ in
                self.tasks[taskType]![indexPath.row].status = .complited
                self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            }
            return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
        }
        
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполненна") { _, _, _ in
            self.tasks[taskType]![indexPath.row].status = .planned
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }

        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
    
    //Удаляем задачу
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPositions[indexPath.section]
        tasks[taskType]?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    
    //Ручная сортировка списка задач
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskTypeFrom = sectionsTypesPositions[sourceIndexPath.section]
        let taskTypeTo = sectionsTypesPositions[destinationIndexPath.section]
        
        guard let movedTask = tasks[taskTypeFrom]?[sourceIndexPath.row] else {
            return
        }
        
        tasks[taskTypeFrom]!.remove(at: sourceIndexPath.row)
        tasks[taskTypeTo]!.insert(movedTask, at: destinationIndexPath.row)
        if taskTypeFrom != taskTypeTo {
            tasks[taskTypeTo]![destinationIndexPath.row].type = taskTypeTo
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateScreen" {
            let destination = segue.destination as! TaskEditController
            destination.doAfterEdit = { [unowned self ] title, type, status in
                let newTask = Task(title: title, type: type, status: status)
                tasks[type]?.append(newTask)
                tableView.reloadData()
            }
        }
    }
    
    private func getSymbolForTask(with status: TaskStatus) -> String {
    var resultSymbol: String
    if status == .planned {
    resultSymbol = "\u{25CB}"
    } else if status == .complited {
    resultSymbol = "\u{25C9}"
        
    } else {
    resultSymbol = ""
    }
    return resultSymbol
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let taskType = sectionsTypesPositions[section]
        if taskType == .important {
            title = "Важные"
        } else if taskType == .normal {
            title = "Прочие"
        }
        return title
    }
}
