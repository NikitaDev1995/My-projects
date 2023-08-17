//
//  AuditViewController.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 05.07.2023.
//

import UIKit

class AuditViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var checkLanguageButton: UIBarButtonItem!
    
    @IBOutlet var wordCounterLabel: [UILabel]!
    @IBOutlet var wordImage: [UIImageView]!
    @IBOutlet var englishWordLabel: [UILabel]!
    @IBOutlet var russianWordLabel: [UILabel]!
    @IBOutlet var checkWordButton: [UIButton]!
    @IBOutlet var nextWordButton: [UIButton]!
    
    @IBOutlet weak var auditStackView: UIStackView!
    @IBOutlet weak var repeatStackView: UIStackView!
    
    //MARK: - Properties
    
    var attributes = [NSAttributedString.Key.foregroundColor: Resources.Colors.Beige.labelTextColor]
    
    var listOfEnglishLevelWords: [Word] = []
    private var nextArrayWords: [Word] = []
    
    private var repeatWordsArray: [Word] = []
    private var nextRepeatWords: [Word] = []
    
    private var counterForCheckWordButton = 0
    private var counterForCheckWordLabel = 0
   private var isChangedLanguageCheck: Bool = true
    
    //MARK: - Life scene cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configure()
    }
    
    //MARK: - Methods
    
    private func loadWord(_ words: [Word]) {
        let word = words.randomElement()
        if !auditStackView.isHidden {
            wordCounterLabel[0].text = "Осталось слов: \(words.count)"
            
            wordImage[0].image = word?.image ?? UIImage(named: "questionMark")
            englishWordLabel[0].text = word?.englishWord ?? "Английское слово"
            russianWordLabel[0].text = word?.russianWord ?? "Русское слово"
        } else {
            wordCounterLabel[1].text = "Осталось слов: \(words.count)"
            
            wordImage[1].image = word?.image ?? UIImage(named: "questionMark")
            englishWordLabel[1].text = word?.englishWord ?? "Русское слово"
            russianWordLabel[1].text = word?.russianWord ?? "Английское слово"
        }
    }
    
    private func changeLanguage(_ isChangedLanguageCheck: Bool) {
        if !auditStackView.isHidden {
            if isChangedLanguageCheck {
                let randomIndex = nextArrayWords.indices.randomElement()
                let randomEnglishWord = nextArrayWords[randomIndex!].englishWord
                let randomRussianWord = nextArrayWords[randomIndex!].russianWord
                let randomImageWord = nextArrayWords[randomIndex!].image
                russianWordLabel[0].textColor = .clear
                englishWordLabel[0].text = randomEnglishWord
                russianWordLabel[0].text = randomRussianWord
                wordImage[0].image = randomImageWord ?? UIImage(named: "questionMark")
                
                nextArrayWords.remove(at: randomIndex!)
                wordCounterLabel[0].text = "Осталось слов: \(nextArrayWords.count)"
            } else {
                let randomIndex = nextArrayWords.indices.randomElement()
                let randomEnglishWord = nextArrayWords[randomIndex!].englishWord
                let randomRussianWord = nextArrayWords[randomIndex!].russianWord
                let randomImageWord = nextArrayWords[randomIndex!].image ?? UIImage(named: "questionMark")
                russianWordLabel[0].textColor = .clear
                englishWordLabel[0].text = randomRussianWord
                russianWordLabel[0].text = randomEnglishWord
                wordImage[0].image = randomImageWord
                
                nextArrayWords.remove(at: randomIndex!)
                wordCounterLabel[0].text = "Осталось слов: \(nextArrayWords.count)"
            }
        } else if auditStackView.isHidden {
            if isChangedLanguageCheck {
                let randomIndex = nextRepeatWords.indices.randomElement()
                let randomEnglishWord = nextRepeatWords[randomIndex!].englishWord
                let randomRussianWord = nextRepeatWords[randomIndex!].russianWord
                let randomImageWord = nextRepeatWords[randomIndex!].image
                russianWordLabel[1].textColor = .clear
                englishWordLabel[1].text = randomEnglishWord
                russianWordLabel[1].text = randomRussianWord
                wordImage[1].image = randomImageWord ?? UIImage(named: "questionMark")
                
                nextRepeatWords.remove(at: randomIndex!)
                wordCounterLabel[1].text = "Осталось слов: \(nextRepeatWords.count)"
            } else {
                let randomIndex = nextRepeatWords.indices.randomElement()
                let randomEnglishWord = nextRepeatWords[randomIndex!].englishWord
                let randomRussianWord = nextRepeatWords[randomIndex!].russianWord
                let randomImageWord = nextRepeatWords[randomIndex!].image ?? UIImage(named: "questionMark")
                russianWordLabel[1].textColor = .clear
                englishWordLabel[1].text = randomRussianWord
                russianWordLabel[1].text = randomEnglishWord
                wordImage[1].image = randomImageWord
                
                nextRepeatWords.remove(at: randomIndex!)
                wordCounterLabel[1].text = "Осталось слов: \(nextRepeatWords.count)"
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func changeLanguageWordButton(_ sender: UIBarButtonItem) {
        if isChangedLanguageCheck {
            navigationItem.rightBarButtonItem?.title = "Рус"
        } else {
            navigationItem.rightBarButtonItem?.title = "Eng"
        }
        isChangedLanguageCheck.toggle()
    }
    
    
    @IBAction func changeModeAction(_ sender: UISegmentedControl) {
        counterForCheckWordLabel += 1
        if sender.selectedSegmentIndex == 0 {
            repeatStackView.isHidden = true
            auditStackView.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            auditStackView.isHidden = true
            repeatStackView.isHidden = false
        }
    }
    
    
    @IBAction func checkWordAction(_ sender: UIButton) {
        if !auditStackView.isHidden {
            counterForCheckWordButton += 1
            russianWordLabel[0].textColor = .red
            checkWordButton[0].setText("Добавить слово на повторение?")
            let repeatWord = Word(englishWord: englishWordLabel[0].text!, russianWord: russianWordLabel[0].text!, wordLevel: englishWordLabel[0].text!, image: wordImage[0].image)
            if counterForCheckWordButton == 2 {
                repeatWordsArray.append(repeatWord)
                modeSegmentedControl.isEnabled = true
                if counterForCheckWordLabel == 0 {
                    wordCounterLabel[1].text = "Осталось слов: \(repeatWordsArray.count)"
                } else {
                    wordCounterLabel[1].text = "Осталось слов: \(nextRepeatWords.count)"
                }
                checkWordButton[0].isEnabled = false
            }
        } else if auditStackView.isHidden == true {
            russianWordLabel[1].textColor = .red
        }
    }
    
    
    @IBAction func nextWordAction(_ sender: UIButton) {
        if !auditStackView.isHidden {
            counterForCheckWordButton = 0
            
            if listOfEnglishLevelWords.isEmpty {
                return
            }
            
            if nextArrayWords.isEmpty {
                wordCounterLabel[0].text = "Осталось слов: 0"
                nextArrayWords = listOfEnglishLevelWords
            }
            
            changeLanguage(isChangedLanguageCheck)
            
            checkWordButton[0].isEnabled = true
            checkWordButton[0].setText("Проверить слово")
            
        } else if auditStackView.isHidden {
          
            if repeatWordsArray.isEmpty {
                return
            }
            
            if nextRepeatWords.isEmpty {
                wordCounterLabel[1].text = "Осталось слов: 0"
                nextRepeatWords = repeatWordsArray
            }
            
            changeLanguage(isChangedLanguageCheck)
        }
    }
}

extension AuditViewController {
    
    private func setupAppearanceLabel(labelArray: [UILabel]) {
        labelArray.forEach { label in
            label.layer.cornerRadius = 10
            label.layer.borderWidth = 2
            label.textColor = Resources.Colors.Beige.labelTextColor
            label.font = Resources.Fonts.font(size: 22)
        }
    }
    
    private func setupAppearanceButton(buttonArray: [UIButton]) {
        buttonArray.forEach { button in
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
        }
        
    }
    
    private func setupAppearanceImage(imageArray: [UIImageView]) {
        imageArray.forEach { image in
            image.layer.cornerRadius = 20
            image.layer.borderWidth = 2
            image.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    
    private func configure() {
        
        navigationController?.navigationBar.tintColor = Resources.Colors.Beige.barTextColor
        
        modeSegmentedControl.setTitleTextAttributes(attributes, for: .selected)
        
        repeatStackView.isHidden = true
        russianWordLabel[0].textColor = .red
        russianWordLabel[1].textColor = .red
        checkWordButton[0].isEnabled = false
        modeSegmentedControl.isEnabled = false
        modeSegmentedControl.layer.borderWidth = 2
        wordCounterLabel[0].text = "Осталось слов: \(listOfEnglishLevelWords.count)"
        
        setupAppearanceLabel(labelArray: wordCounterLabel)
        setupAppearanceLabel(labelArray: englishWordLabel)
        setupAppearanceLabel(labelArray: russianWordLabel)
        
        setupAppearanceButton(buttonArray: checkWordButton)
        setupAppearanceButton(buttonArray: nextWordButton)
        
        setupAppearanceImage(imageArray: wordImage)
        
    }
}

