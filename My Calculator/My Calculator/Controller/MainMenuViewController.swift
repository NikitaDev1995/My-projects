//
//  ContainerViewController.swift
//  My Calculator
//
//  Created by Nikita Skripka on 07.07.2022.
//

import UIKit


class MainMenuViewController: UIViewController {

    @IBOutlet var bankButtons: [UIButton]!
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    func setupView() {
        self.view.backgroundColor = Theme.currentTheme.backGorundColor
        settingsButton.tintColor = Theme.currentTheme.textColor
        bankButtons.forEach { button in
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.red.cgColor
    }
    }
    }
    
    

extension String {
    static let numberFormater = NumberFormatter()
    var doubleValue: Double {
        String.numberFormater.decimalSeparator = "."
        if let result = String.numberFormater.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormater.decimalSeparator = ","
            if let result = String.numberFormater.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
