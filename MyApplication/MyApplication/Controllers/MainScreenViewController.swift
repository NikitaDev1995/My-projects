//
//  MainScreenViewController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 04.04.2022.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    @IBOutlet var contactsTableButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCharactersButton()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - настройки Buttons
    func changeCharactersButton() {
        contactsTableButton.forEach { btn in
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.red.cgColor
        }
    }
    
}
