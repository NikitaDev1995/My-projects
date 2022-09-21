//
//  OptionsScheduleViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 24.08.2022.
//

import UIKit

class ScheduleOptionsTableViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    private let headerNameArray = ["DATE AND TIME","LESSON","TEACHER","COLOR","PERIOD"]
    var cellNameArray = [["Date","Time"],["Name","Type","Building","Audience"],["Teacher","Name"],[""],["Repeat every 7 days"]]
    
    var scheduleModel = ScheduleModel()
    
    var hexColorCell = "0433FF"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Schedule"
        
        tableView.bounces = false
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        // Do any additional setup after loading the view.
    }
    
    @objc private func saveButtonTapped() {
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleTime == nil || scheduleModel.scheduleName == "Unknown" {
            alertOk(title: "Error", message: "Requered to enter: NAME, TIME, DATE")
        } else {
            scheduleModel.scheduleColor = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            alertOk(title: "Success", message: nil)
            hexColorCell = "0433FF"
            cellNameArray[2][0] = "Teacher Name"
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 2
        case 1:
            return 4
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.switchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { [self] (numberWeekDay, date) in
            scheduleModel.scheduleDate = date
            scheduleModel.scheduleWeekday = numberWeekDay
        }
        case [0,1]:  alertTime(label: cell.nameCellLabel, completionHendler: { [self] (time) in
            scheduleModel.scheduleTime = time
        })
        case [1,0]: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson", complition: { [self] (name) in
            scheduleModel.scheduleName = name
        })
        case [1,1]: alertForCellName(label: cell.nameCellLabel, name: "Type", placeholder: "Enter type", complition: { [self] (type) in
            scheduleModel.scheduleType = type
        })
        case [1,2]: alertForCellName(label: cell.nameCellLabel, name: "Building", placeholder: "Enter building", complition: { [self] (building) in
            scheduleModel.scheduleBuilding = building
        })
        case [1,3]: alertForCellName(label: cell.nameCellLabel, name: "Audience", placeholder: "Enter audience", complition: { [self] (audience) in
            scheduleModel.scheduleAudience = audience
        })
        case [2,0]: pushControllers(vc: TeachersViewController())
        case [3,0]: pushControllers(vc: ScheduleColorsViewController())
        default:
            print("Tap OptionsTableView")
        }
    }
    
    private func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ScheduleOptionsTableViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        scheduleModel.scheduleRepeat = value
    }
}
