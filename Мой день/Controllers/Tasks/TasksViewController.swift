//
//  TasksViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 22.08.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class TasksViewController: UIViewController {
    
    private var calendarHighConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private var showHighButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let localRealm = try! Realm()
    private var tasksArray: Results<TasksModel>!
    
    private let idTasksCell = "idTasksCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Tasks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: idTasksCell)
        tableView.delegate  = self
        tableView.dataSource = self
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        
        setConstraints()
        
        tasksOnDay(date: calendar.today!)
        showHighButton.addTarget(self, action: #selector(showHighButtonTapped), for: .touchUpInside)
        swipeAction()
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func addButtonTapped() {
        let tasksOption = TasksOptionTableViewController()
        navigationController?.pushViewController(tasksOption, animated: true)
    }
    
    @objc private func showHighButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHighButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHighButton.setTitle("Open calendar", for: .normal)
        }
    }
    
    //MARK: SwipeGestureRecognizer
    
    private func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            calendar.setScope(.week, animated: true)
            showHighButton.setTitle("Open calendar", for: .normal)
        case .down:
            calendar.setScope(.month, animated: true)
            showHighButton.setTitle("Close calendar", for: .normal)
        default:
            break
        }
    }
    
    private func tasksOnDay(date: Date) {
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicate = NSPredicate(format: "tasksDate BETWEEN %@", [dateStart, dateEnd])
        tasksArray = localRealm.objects(TasksModel.self).filter(predicate)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableVIewDataSource

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTasksCell, for: indexPath) as! TasksTableViewCell
        cell.cellTaskDelegate = self
        cell.index = indexPath
        let model = tasksArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let aditingRow = tasksArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteTasksModel(model: aditingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}

//MARL: - PressReadyTaskButtonProtocol

extension TasksViewController: PressReadyTaskButtonProtocol {
    func readyButtonTapped(indexPath: IndexPath) {
        let task = tasksArray[indexPath.row]
        RealmManager.shared.updateReadyButtonTaskModel(task: task, bool: !task.taskReady)
        tableView.reloadData()
    }
}

//MARK: - FSCalendarDataSource, FSCalendarDelegate

extension TasksViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHighConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasksOnDay(date: date)
    }
}

//MARK: - setConstraints

extension TasksViewController {
    
    private func setConstraints() {
        
        view.addSubview(calendar)
        
        calendarHighConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHighConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
        ])
        
        view.addSubview(showHighButton)
        NSLayoutConstraint.activate([
            showHighButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHighButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            showHighButton.widthAnchor.constraint(equalToConstant: 140),
            showHighButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHighButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
