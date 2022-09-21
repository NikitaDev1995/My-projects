//
//  NewAccountViewController.swift
//  MyApplication
//
//  Created by Nikita Skripka on 06.04.2022.
//

import UIKit


class NewAccountViewController: UIViewController {

    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var newNameTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePlaceholder()
        changeCharactersButtons()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Настройки textField
    func changePlaceholder() {
        newNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        newPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Создайте пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Подтвердите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    

    
    //MARK: - Настройки Button
    func changeCharactersButtons() {
        confirmButton.layer.cornerRadius = 5
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func saveButton() {
        //FIXME: Исправить валидацию пароля
        guard myLogin.object(forKey: newNameTextField.text!) != nil else {
            if newNameTextField.text! == "" {
            let  allertMessage = UIAlertController(title: "Ошибка", message: "Введите имя", preferredStyle: .alert)
            allertMessage.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(allertMessage, animated: true, completion: nil)
                return
            }
            if newPasswordTextField.text == passwordTextField.text {
                if newPasswordTextField.text != "" && passwordTextField.text != "" {
                    myLogin.set(newPasswordTextField.text!, forKey: newNameTextField.text!)
                    let allertMessage = UIAlertController(title: "Успешно", message: "Имя и пароль созданны", preferredStyle: .alert)
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
            return
        }
        
        let  allertMessage = UIAlertController(title: "Ошибка", message: "Имя уже существует", preferredStyle: .alert)
        allertMessage.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(allertMessage, animated: true, completion: nil)
    }
    
    
    
    }




//MARK: - extension
extension NewAccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newNameTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
