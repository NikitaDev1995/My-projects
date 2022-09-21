//
//  ViewController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 04.04.2022.
//

import UIKit


class LoginScreenViewController: UIViewController {
    

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var enterPassword: UILabel!
    @IBOutlet var accountMenu: [UIButton]!
    @IBOutlet var accountMenuTwo: [UIButton]!
//   private lazy var allowedCharacters = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{6,12}$"
    
        override func viewDidLoad() {
        super.viewDidLoad()
            changeCharactersButtons()
            dropDownMenu()
            changePlaceholder()
        // Do any additional setup after loading the view.
    }
   
    //MARK: - Настройки Button
    func changeCharactersButtons() {
        accountMenuTwo.forEach { (btn) in
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func dropDownMenu() {
        accountMenu.forEach { (btn) in
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.red.cgColor
            btn.isHidden = true
            btn.alpha = 0
        }
    }
    
    @IBAction func accountMenuButton(_ sender: UIButton) {
        accountMenu.forEach { btn in
            UIView.animate(withDuration: 0) {
                btn.isHidden = !btn.isHidden
                btn.alpha = btn.alpha == 0 ? 1 : 0
                btn.layoutIfNeeded()
            }
        }
    }
    
    //MARK: - Настройки textField
    func changePlaceholder() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray ])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
   
    //переход при помощи segue
    private func prepareMainScreen(_ segue: UIStoryboardSegue) {

    guard myLogin.object(forKey: nameTextField.text!) != nil else {
        
    let allertMessage = UIAlertController(title: "Внимание", message: "Имя или пароль неверен", preferredStyle: .alert)
    allertMessage.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(allertMessage, animated: true, completion: nil)
        
    return
        
    }
    if passwordTextField.text! == myLogin.value(forKey: nameTextField.text!) as? String ?? "" {
    passwordTextField.text = ""
    nameTextField.text = ""
    } else {
        
        let allert = UIAlertController(title: "Внимание", message: "Имя или пароль неверен", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(allert, animated: true, completion: nil)
        
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toMainScreen":
            prepareMainScreen(segue)
        default:
            break
        }
    }
    
    
    
    @IBAction func clearButton(_ sender: UIButton) {
    let dictionary = myLogin.dictionaryRepresentation()
    dictionary.keys.forEach { key in
    myLogin.removeObject(forKey: key)
    }
        
    }
    
    
    
    
    
    
    
    
}
//MARK: - extension
extension LoginScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        return true
    }

}
