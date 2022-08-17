//
//  LoanViewController.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.06.2022.
//

import UIKit

class LoanViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var amountOfMounth: UITextField!
    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var percent: UITextField!
    
    
    var calculate: CalculateOfLoan {
        CalculateOfLoan(percent: percent.text!, loan: loanAmount.text!, countOfMounth: amountOfMounth.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        segmentedControl.addTarget(self, action: #selector(segmentedAction(sender:)), for: .valueChanged)
        calculateButton.layer.borderWidth = 2
        calculateButton.layer.borderColor = UIColor.red.cgColor
        calculateButton.layer.cornerRadius = 10
        self.view.backgroundColor = Theme.currentTheme.backGorundColor
        nameLabel.textColor = Theme.currentTheme.textColor
        calculationLabel.textColor = Theme.currentTheme.textColor
        amountOfMounth.textColor = Theme.currentTheme.textColor
        loanAmount.textColor = Theme.currentTheme.textColor
        percent.textColor = Theme.currentTheme.textColor
        amountOfMounth.attributedPlaceholder = NSAttributedString(string: "Кол. месяцев", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        loanAmount.attributedPlaceholder = NSAttributedString(string: "Сум. займа", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        percent.attributedPlaceholder = NSAttributedString(string: "Процент", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
    }
    
    @objc func segmentedAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loanAmount.text = ""
            amountOfMounth.text = ""
            percent.text = ""
            nameLabel.text = "Дифференцированный платеж"
            
        case 1:
            loanAmount.text = ""
            amountOfMounth.text = ""
            percent.text = ""
            nameLabel.text = "Аннуитетный платеж"
        default:
            break
        }
    }
    
     
    
    @IBAction func calculate(_ sender: UIButton) {
        if segmentedControl.selectedSegmentIndex == 0 {
            calculationLabel.text = calculate.differentiatedSettlement
        } else if segmentedControl.selectedSegmentIndex == 1 {
            calculationLabel.text = calculate.annuityCalculation
        }
        
    }
    
}

extension LoanViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case amountOfMounth:
            if ((textField.text?.count)! + (string.count - range.length)) > 3 {
                return false
            }
        case loanAmount:
            if ((textField.text?.count)! + (string.count - range.length)) > 9 {
                return false
            }
            
        case percent:
            if ((textField.text?.count)! + (string.count - range.length)) > 3 {
                return false
            }
        default:
            break
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

