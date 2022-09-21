//
//  SettingsViewController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 08.05.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    private var data = ["Темная тема", "Размер шрифта"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "Ctroka \(data)"
        cell.contentConfiguration = configuration
        return cell
    }
    
    
    
}




extension SettingsViewController: UITableViewDelegate {
    
}
