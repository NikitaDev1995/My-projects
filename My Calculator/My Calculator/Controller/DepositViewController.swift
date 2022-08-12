//
//  DepositController.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.06.2022.
//

import UIKit

class DepositViewController: UIViewController {

    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var calculationLabel: UILabel!
    @IBOutlet var percent: UITextField!
    @IBOutlet var depositAmount: UITextField!
    @IBOutlet var amountsOfDays: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var calculate: CalculatorOfDeposit {
        CalculatorOfDeposit(depositAmount: depositAmount.text!, percent: percent.text!, countOfDays: amountsOfDays.text!)
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
        calculateButton.layer.backgroundColor = UIColor.orange.cgColor
        calculateButton.layer.borderColor = UIColor.red.cgColor
        calculateButton.layer.borderWidth = 1
        calculateButton.layer.cornerRadius = 10
        depositAmount.attributedPlaceholder = NSAttributedString(string: "Депозит", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        percent.attributedPlaceholder = NSAttributedString(string: "Процент", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        amountsOfDays.attributedPlaceholder = NSAttributedString(string: "Кол. дней", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        self.view.backgroundColor = Theme.currentTheme.backGorundColor
        nameLabel.textColor = Theme.currentTheme.textColor
        calculationLabel.textColor = Theme.currentTheme.textColor
        depositAmount.textColor = Theme.currentTheme.textColor
        amountsOfDays.textColor = Theme.currentTheme.textColor
        percent.textColor = Theme.currentTheme.textColor
    }
    
    @objc func segmentedAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            percent.text = ""
            depositAmount.text = ""
            amountsOfDays.text = ""
            nameLabel.text = "Заработок с депозита"
            depositAmount.attributedPlaceholder = NSAttributedString(string: "Депозит", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
            percent.attributedPlaceholder = NSAttributedString(string: "Процент", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
            amountsOfDays.attributedPlaceholder = NSAttributedString(string: "Кол. дней", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        case 1:
            percent.text = ""
            depositAmount.text = ""
            amountsOfDays.text = ""
            nameLabel.text = "Желаемая сумма"
            depositAmount.attributedPlaceholder = NSAttributedString(string: "Cумма. мес", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
            percent.attributedPlaceholder = NSAttributedString(string: "Процент", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
            amountsOfDays.attributedPlaceholder = NSAttributedString(string: "Кол. дней", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        default:
            break
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
    if segmentedControl.selectedSegmentIndex == 0 {
    nameLabel.text = "Заработок с депозита"
    calculationLabel.text = calculate.calculateOfProfitable
    } else if segmentedControl.selectedSegmentIndex == 1 {
    nameLabel.text = "Желаемая сумма"
    calculationLabel.text = calculate.calculateMonthlyAmount
    }
    }
    
}

extension DepositViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


