//
//  ChangeBankViewController.swift
//  My Calculator
//
//  Created by Nikita Skripka on 27.07.2022.
//

import UIKit

class ChangeBankViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellID = "BankTableViewCell"
    var modelBank = ModelBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = Theme.currentTheme.backGorundColor
        tableView.backgroundColor = Theme.currentTheme.backGorundColor
        
    }
}


extension ChangeBankViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = modelBank.banks[section]
        return section.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelBank.banks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Рассрочки"
        }
        return "Карты"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! BankTableViewCell
        let section = modelBank.banks[indexPath.section]
        let bank = section[indexPath.row]
        cell.backgroundColor = Theme.currentTheme.backGorundColor
        cell.bankLabel.textColor = Theme.currentTheme.textColor
        cell.bankLabel.text = bank.name
        cell.bankImage.image = bank.image
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToBank", sender: indexPath)
        //Мигание при выборе ячейки
        tableView.deselectRow(at: indexPath, animated: true)
}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBank" {
            let vc = segue.destination as! BankViewController
            let indexPath = sender as! IndexPath
            let section = modelBank.banks[indexPath.section]
            let bank = section[indexPath.row]
            vc.bank = bank
        }
    }

}
