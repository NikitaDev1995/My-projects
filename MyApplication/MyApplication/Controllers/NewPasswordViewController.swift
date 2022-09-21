//
//  NewPasswordViewController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 05.04.2022.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        changePlaceholder()
        changeCharactersButtons()
        // Do any additional setup after loading the view.
    }
    
//MARK: - Настройки textField
    func changePlaceholder() {
        newPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Введите новый пароль", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray ])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Подтвердите новый пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    
    //MARK: - Настройки Button
    func changeCharactersButtons() {
        confirmButton.layer.cornerRadius = 5
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.red.cgColor
    }
    

    
    @IBAction func confirmButtonPassword() {
        //FIXME: Исправить валидацию пароля
        
        guard myLogin.object(forKey: nameTextField.text!) != nil else {
        let allertMessage = UIAlertController(title: "Ошибка", message: "Имя ненайденно", preferredStyle: .alert)
        allertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(allertMessage, animated: true, completion: nil)
        return
        }
        
        if newPasswordTextField.text == passwordTextField.text {
            if newPasswordTextField.text != "" && passwordTextField.text != "" {
                myLogin.set(newPasswordTextField.text!, forKey: nameTextField.text!)
                let allertMessage = UIAlertController(title: "Успешно", message: "Пароль изменен", preferredStyle: .alert)
                allertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(allertMessage, animated: true, completion: nil)
            } else {
                let allertMessage = UIAlertController(title: "Ошибка", message: "Введите пароль", preferredStyle: .alert)
                allertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(allertMessage, animated: true, completion: nil)
            }
        } else {
            let allertMessage = UIAlertController(title: "Ошибка", message: "Пароли несовпадают", preferredStyle: .alert)
            allertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(allertMessage, animated: true, completion: nil)
        }
        
    }

}

//MARK: - extension
extension NewPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
