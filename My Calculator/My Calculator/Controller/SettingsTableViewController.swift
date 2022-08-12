//
//  SettingsTableViewController.swift
//  My Calculator
//
//  Created by Nikita Skripka on 30.07.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
   
    
    @IBOutlet weak var switchTheme: UISwitch!
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var modeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        switchTheme.isOn = UserDefaults.standard.bool(forKey: "DarkTheme")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modeLabel.text = switchTheme.isOn ? "Темная тема" : "Светлая тема"
    }
    
   private func setupView() {
        self.view.backgroundColor = Theme.currentTheme.backGorundColor
        cell1.backgroundColor = Theme.currentTheme.cellColor
        modeLabel.textColor = Theme.currentTheme.textColor
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        modeLabel.text = sender.isOn ? "Темная тема" : "Светлая тема"
        Theme.currentTheme = sender.isOn ? DarkTheme() : LightTheme()
        setupView()
        //WARNING: - Вынести юзерДефолтс за класс
        UserDefaults.standard.set(sender.isOn, forKey: "DarkTheme")
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

