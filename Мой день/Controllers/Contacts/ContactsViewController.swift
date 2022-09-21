//
//  ContactsTableViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 29.08.2022.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    private let idContactsCell = "idContactsCell"
    
    private let searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Search"
        return search
    }()
    
    private let segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Friends","Teachers"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
   private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private var localRealm = try! Realm()
    private var contactArray: Results <ContactModel>!
    private var filterContactArray: Results <ContactModel>!
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    var isFiltring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        
        setConstraints()
        
        contactArray = localRealm.objects(ContactModel.self).filter("contactType = 'Friend'")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        segmentedControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
    }
    
    @objc private func addButtonTapped() {
        navigationController?.pushViewController(ContactsOptionsTableViewController(), animated: true)
    }
    
    @objc private func editingModel(contactModel: ContactModel) {
        let contactOption = ContactsOptionsTableViewController()
        contactOption.contactModel = contactModel
        contactOption.editModel = true
        contactOption.cellNameArray = [contactModel.contactName, contactModel.contactPhone, contactModel.contactMail, contactModel.contactType, ""]
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    @objc private func segmentChange() {
        if segmentedControl.selectedSegmentIndex == 0 {
            contactArray = localRealm.objects(ContactModel.self).filter("contactType = 'Friend'")
            tableView.reloadData()
        } else {
            contactArray = localRealm.objects(ContactModel.self).filter("contactType = 'Teacher'")
            tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableVIewDataSource

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltring ? filterContactArray.count : contactArray.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        let model = (isFiltring ? filterContactArray[indexPath.row] : contactArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactArray[indexPath.row]
        editingModel(contactModel: model)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - Search
extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterContactArray = contactArray.filter("contactName CONTAINS[cd] %@", searchText)
        print(searchBarIsEmpty)
        tableView.reloadData()
    }
    
    
}

//MARK: - Constraints
extension ContactsViewController {
    private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl,tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
