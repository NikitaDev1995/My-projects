//
//  ToDoListController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 22.04.2022.
//

import UIKit

class ToDoListController: UIViewController {

    var userDefaults = UserDefaults.standard
    
    @IBOutlet var tableView: UITableView!
    
    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
        // Do any additional setup after loading the view.
    }
    private func loadContacts() {
        contacts.append(Contact.init(title: "Teresa", phone: "1"))
        contacts.append(Contact.init(title: "Denev", phone: "15"))
        contacts.append(Contact.init(title: "Galateya", phone: "3"))
        
    }
    
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(title: "Создание нового контакта", message: "Введите имя и номер клеймора", preferredStyle: .alert)
        alertController.addTextField {textField in textField.placeholder = "Имя"}
        alertController.addTextField {textField in textField.placeholder = "Номер в организации"}
        alertController.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text else {
                return
            }
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - extensions
extension ToDoListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let newCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            cell = newCell
        } else {
        cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
    
    
}

extension ToDoListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
