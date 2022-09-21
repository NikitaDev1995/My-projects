//
//  TeachersViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 27.08.2022.
//

import UIKit
import RealmSwift

class TeachersViewController: UITableViewController {
    
    private let localRealm = try! Realm()
    private var contactsArray: Results <ContactModel>!
    private var teacherID = "teacherID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Teachers"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: teacherID)
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactType = 'Teacher'")
        // Do any additional setup after loading the view.
    }
    
    private func setTeacher(teacher: String) {
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOptions?.scheduleModel.scheduleTeacher = teacher
        scheduleOptions?.cellNameArray[2][0] = teacher
        scheduleOptions?.tableView.reloadRows(at: [[2,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teacherID, for: indexPath) as! ContactsTableViewCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        setTeacher(teacher: model.contactName)
    }
}
