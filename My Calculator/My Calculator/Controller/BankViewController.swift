//
//  BankViewController.swift
//  My Calculator
//
//  Created by Nikita Skripka on 29.07.2022.
//

import UIKit

class BankViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var calculateLabel: UILabel!
    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var amountOfMounth: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
  
    
    var bank: Bank!
    
    var calculate: CalculateOfInstallment {
        CalculateOfInstallment(installment: loanAmount.text!, countOfMounth: amountOfMounth.text!, bank: bank)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = bank.image
        calculateButton.layer.cornerRadius = 10
        calculateButton.layer.borderWidth = 2
        calculateButton.layer.borderColor = UIColor.red.cgColor
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        
    }
    
    private func setupView() {
        self.view.backgroundColor = Theme.currentTheme.backGorundColor
        nameLabel.textColor = Theme.currentTheme.textColor
        calculateLabel.textColor = Theme.currentTheme.textColor
        loanAmount.textColor = Theme.currentTheme.textColor
        amountOfMounth.textColor = Theme.currentTheme.textColor
        loanAmount.attributedPlaceholder = NSAttributedString(string: "Сумма чека", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        amountOfMounth.attributedPlaceholder = NSAttributedString(string: "Кол. месяцев", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
    }
    
    
    @IBAction func calculateButton(_ sender: Any) {
        guard Int(loanAmount.text!) ?? 0 >= 3000 else {
            return calculateLabel.text = "Cумма не должна быть ниже 3000"
        }
        guard amountOfMounth.text == "6" || amountOfMounth.text == "12" || amountOfMounth.text == "18" else {
            return calculateLabel.text = "Укажите колличество месяцев 6, 12, 18"
        }
        
        calculateLabel.text = String(calculate.calculateOfInstallment)
    }
    

}

extension BankViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
