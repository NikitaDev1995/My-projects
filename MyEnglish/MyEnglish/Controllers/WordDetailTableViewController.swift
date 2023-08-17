//
//  WordDetailTableViewController.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 27.06.2023.
//

import UIKit


class WordDetailTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var englishWordTextField: UITextField!
    @IBOutlet weak var russianWordTextField: UITextField!
    @IBOutlet weak var englishWordLevelSegmentedController: UISegmentedControl!
    @IBOutlet weak var wordImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: - Properties
    
    var word: Word?
    
    //MARK: - Scene life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        if let word = word {
            navigationItem.title = "Слово"
            englishWordTextField.text = word.englishWord
            russianWordTextField.text = word.russianWord
            wordImageView.image = word.image
            switch word.wordLevel {
            case "A0":
                englishWordLevelSegmentedController.selectedSegmentIndex = 0
            case "A1":
                englishWordLevelSegmentedController.selectedSegmentIndex = 1
            case "A2":
                englishWordLevelSegmentedController.selectedSegmentIndex = 2
            case "B1":
                englishWordLevelSegmentedController.selectedSegmentIndex = 3
            case "B2":
                englishWordLevelSegmentedController.selectedSegmentIndex = 4
            case "C1":
                englishWordLevelSegmentedController.selectedSegmentIndex = 5
            case "SE":
                englishWordLevelSegmentedController.selectedSegmentIndex = 6
            case "DPA": englishWordLevelSegmentedController.selectedSegmentIndex = 7
            default: break
            }
        }
        updateSaveButtonState()
    }
    
    //MARK: - Methods
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButtonState = (englishWordTextField.text?.isEmpty == false && russianWordTextField.text?.isEmpty == false)
        saveButton.isEnabled = shouldEnableSaveButtonState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let segmentedIndex = englishWordLevelSegmentedController.selectedSegmentIndex
        
        let englishWord = englishWordTextField.text!.trimmingCharacters(in: .whitespaces)
        let russianWord = russianWordTextField.text!.trimmingCharacters(in: .whitespaces)
        let wordLevel = englishWordLevelSegmentedController.titleForSegment(at: segmentedIndex)!
        let image = wordImageView.image
        
        if word != nil {
            word?.englishWord = englishWord
            word?.russianWord = russianWord
            word?.wordLevel = wordLevel
            word?.image = image
        } else {
            word = Word(englishWord: englishWord, russianWord: russianWord, wordLevel: wordLevel, image: image)
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Камера", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Библиотека", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sender
        
        present(alertController, animated: true)
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

extension WordDetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        russianWordTextField.resignFirstResponder()
        englishWordTextField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        wordImageView.image = selectedImage
        dismiss(animated: true)
    }
    
}

extension WordDetailTableViewController {

    private func configure() {
        view.backgroundColor = Resources.Colors.Beige.backGroundView
        
        wordImageView.layer.borderWidth = 2
        wordImageView.layer.borderColor = UIColor.gray.cgColor
        wordImageView.image = UIImage(named: "questionMark")
        wordImageView.backgroundColor = .lightGray
        
        addImageButton.layer.cornerRadius = 10
        addImageButton.layer.borderWidth = 2
    }
}
