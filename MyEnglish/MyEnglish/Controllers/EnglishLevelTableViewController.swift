//
//  EnglishLevelTableViewController.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 05.07.2023.
//

import UIKit

class EnglishLevelTableViewController: UITableViewController {
    
    //MARK: - Properties
    let navigationBarAppearance = UINavigationBarAppearance()
    
    var backGroundMainView: UIColor = UIColor(hexString: "#FFF1E1")
    var textColor: (UIColor, UIColor, UIColor) = (button: UIColor(hexString: "#1E3D59"), label: UIColor(hexString: "#1E3D59"), navButton: UIColor(hexString: "#1E3D59"))
    var backGroundButton: UIColor = UIColor(hexString: "#EF6C41")
    
   private var generalWordArray: [Word] = []
   private var begineerArray: [Word] = []
   private var elementaryArray: [Word] = []
   private var preIntermediateArray: [Word] = []
   private var intermediateArray: [Word] = []
   private var uperIntermediateArray: [Word] = []
   private var advancedArray: [Word] = []
   private var stableExpressions: [Word] = []
   private var dependentPrepositionsAndVerbs: [Word] = []
    
    //MARK: - Life scene cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         generalWordArray = []
         begineerArray = []
         elementaryArray = []
         preIntermediateArray = []
         intermediateArray = []
         uperIntermediateArray = []
         advancedArray = []
         stableExpressions = []
         dependentPrepositionsAndVerbs = []
        
        if let savedWords = Word.loadWords() {
            generalWordArray = savedWords
        }
        
        loadWordsArray()
    }
    
    //MARK: - Methods
    
   private func loadWordsArray() {
        for word in generalWordArray {
            switch word.wordLevel {
            case "A0": begineerArray.append(word)
            case "A1": elementaryArray.append(word)
            case "A2": preIntermediateArray.append(word)
            case "B1": intermediateArray.append(word)
            case "B2": uperIntermediateArray.append(word)
            case "C1": advancedArray.append(word)
            case "SE": stableExpressions.append(word)
            case "DPA": dependentPrepositionsAndVerbs.append(word)
            default: break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "BEGINEER":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = begineerArray
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "ELEMENTARY":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = elementaryArray
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "PRE-INTERMEDIATE":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = preIntermediateArray
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "INTERMEDIATE":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = intermediateArray
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "UPER-INTERMEDIATE":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = uperIntermediateArray
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "ADVANCED":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = advancedArray
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "STABLE EXPRESSIONS":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = stableExpressions
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        case "DEPEND PREPOSITIONS, ADJECTIVES":
            if let destinationVC = segue.destination as? AuditViewController {
                destinationVC.listOfEnglishLevelWords = dependentPrepositionsAndVerbs
                configureColorsAuditVC(VC: destinationVC, backGround: backGroundMainView, textColor: textColor, buttonColor: backGroundButton)
            }
        default: break
        }
    }
}

extension EnglishLevelTableViewController {

    private func configure() {
        //изменение цвета NavBar чтобы при скроллинге он не изменялся
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 1, green: 0.945, blue: 0.882, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        view.backgroundColor = Resources.Colors.Beige.backGroundView
        
        navigationController?.navigationBar.tintColor = Resources.Colors.Beige.barTextColor
    }
    
    private func configureColorsAuditVC(VC: UIViewController, backGround: UIColor, textColor: (button: UIColor, label: UIColor, navButton: UIColor), buttonColor: UIColor) {
        if let vc = VC as? AuditViewController {
            navigationController?.navigationBar.tintColor = textColor.navButton
            vc.checkLanguageButton.tintColor = textColor.navButton
            vc.view.backgroundColor = backGround
            vc.englishWordLabel.forEach { text in
                text.textColor = textColor.label
            }
            vc.russianWordLabel.forEach { text in
                text.textColor = textColor.label
            }
            vc.wordCounterLabel.forEach { text in
                text.textColor = textColor.label
            }
            vc.nextWordButton.forEach { button in
                button.tintColor = textColor.button
                button.backgroundColor = buttonColor
            }
            vc.checkWordButton.forEach { button in
                button.tintColor = textColor.button
                button.backgroundColor = buttonColor
            }
            vc.modeSegmentedControl.selectedSegmentTintColor = buttonColor
            vc.modeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColor.button], for: .selected)
        }
    }
}
