//
//  ContactOptionTableViewController.swift
//  Мой день
//
//  Created by Nikita Skripka on 30.08.2022.
//

import UIKit

class ContactsOptionsTableViewController: UITableViewController {
    
    private let idOptionsContactCell = "idOptionsContactCell"
    private let idOptionsContactHeader = "idOptionsContactHeader"
    
    private let nameHeader = ["NAME","PHONE","MAIL","TYPE","CHOOSE IMAGE"]
    var cellNameArray = ["Name","Phone","Mail","Type",""]
    
    var imageIsChanged = false
    var contactModel = ContactModel()
    var editModel = false
    var dataImage: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Contacts"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        print(contactModel)
    }
    
    @objc private func saveButtonTapped() {
        if cellNameArray[0] == "Name" || cellNameArray[1] == "Phone" || cellNameArray[3] == "Type" {
            alertOk(title: "Error", message: "Requered to enter: NAME, PHONE, TYPE")
        } else if editModel == false {
            setImageModel()
            setModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            cellNameArray = ["Name","Phone","Mail","Type",""]
            alertOk(title: "Success", message: nil)
            tableView.reloadData()
        } else {
            setImageModel()
            RealmManager.shared.updateContactModel(model: contactModel, nameArray: cellNameArray, imageData: dataImage)
            navigationController?.popViewController(animated: true)
        }
    }
    private func setModel() {
        contactModel.contactName = cellNameArray[0]
        contactModel.contactPhone = cellNameArray[1]
        contactModel.contactMail = cellNameArray[2]
        contactModel.contactType = cellNameArray[3]
        contactModel.contactImage = dataImage
    }
    @objc private func setImageModel() {
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            
            let image = cell.backGroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            dataImage = imageData
            
            cell.backGroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            dataImage = nil
        }
    }
    //MARK: - UITableViewDataSource, UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        if editModel == false {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactModel.contactImage, let image = UIImage(data: data) {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section <= 3 ? 44 : 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter name contact", complition: { [self] (name) in
            self.cellNameArray[0] = name
        })
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Numperphone Contact", placeholder: "Enter numberphone contact", complition: { [self] (number) in
            self.cellNameArray[1] = number
        })
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter mail contact", complition: { [self] (mail) in
            self.cellNameArray[2] = mail
        })
        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { [self] (type) in
            self.cellNameArray[3] = type
        }
        case 4: alertPhotoOrCamera { [self] source in
            chooseImagePicker(source: source)
        }
        default:
            print("+")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: nameHeader, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}

extension ContactsOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) { //source - источник данных (камера или галерея)
        
        if UIImagePickerController.isSourceTypeAvailable(source) { //Условие если мы имеем доступ к камере или галерее
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true //разрешаем редактирование фотографии( та часть которая будет попадать на экран та фотография будет назначена изображением)
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {//метод передает делегату изображение (отредактированно или нет) и это изображение будет присвоенно в нашу ячейку (imageView)
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        cell.backGroundViewCell.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        cell.backGroundViewCell.contentMode = .scaleAspectFill //присваеваем изображение по всей ячейке
        cell.backGroundViewCell.clipsToBounds = true //обрезаем края
        imageIsChanged = true
        dismiss(animated: true)
    }
}
