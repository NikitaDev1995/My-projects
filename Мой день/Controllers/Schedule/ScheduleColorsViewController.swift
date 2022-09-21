//
//  ScheduleColorViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 27.08.2022.
//

import UIKit

class ScheduleColorsViewController: UITableViewController {
    
    private let idColorCell = "idColorCEll"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    private let headerNameArray = ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Colors Schedule"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.bounces = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
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
        switch indexPath.section {
        case 0: setColor(color: "FF2600")
        case 1: setColor(color: "FF9300")
        case 2: setColor(color: "FFFB00")
        case 3: setColor(color: "00F900")
        case 4: setColor(color: "00FDFF")
        case 5: setColor(color: "0433FF")
        case 6: setColor(color: "A633FF")
        default: setColor(color: "FF2600")
        }
    }
    
    private func setColor(color: String) {
        let scheduleOtions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOtions?.hexColorCell = color
        scheduleOtions?.tableView.reloadRows(at: [[3,0], [4,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
}
