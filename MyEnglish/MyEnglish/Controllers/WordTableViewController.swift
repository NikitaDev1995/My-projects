//
//  WordTableViewController.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 27.06.2023.
//

import UIKit

class WordTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    let navigationBarAppearance = UINavigationBarAppearance()
    
    var backGround: UIColor = UIColor(hexString: "#FFF1E1")
    var textColor: (UIColor, UIColor, UIColor) = (button: UIColor(hexString: "#1E3D59"), label: UIColor(hexString: "#1E3D59"), navButton: UIColor(hexString: "#1E3D59"))
    var buttonBackGround: UIColor = UIColor(hexString: "#EF6C41")
    
    var words = [Word]()
    private var filteredWord = [Word]()
    private var isSearching: Bool = false {
        willSet {
            if newValue == false {
                navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    //MARK: - Scene life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        searchBar.delegate = self
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        if let savedWords = Word.loadWords() {
            words = savedWords
        } else {
            words = Word.loadSampleWords()
        }
        
    }
    
    //MARK: - Methods
    
    func updateCustomCellProperties(textColor: UIColor) {
        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            if let cell = tableView.cellForRow(at: indexPath) as? WordTableViewCell {
                cell.russianWordLabel.textColor = textColor
                cell.englishWordLabel.textColor = textColor
                cell.englishWordLevelLabel.textColor = textColor
            }
        }
    }


    private func deleteWord(at indexPath: IndexPath) {
        let filteredIndex = indexPath.row
        let originalIndex = words.firstIndex(of: filteredWord[filteredIndex])
        
        filteredWord.remove(at: filteredIndex)
        if let originalIndex = originalIndex {
            words.remove(at: originalIndex)
        }
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showWordDetailSegue" {
                if let navVC = segue.destination as? UINavigationController,
                   let wordDetailVC = navVC.topViewController as? WordDetailTableViewController {
                    configureColorsAuditVC(VC: wordDetailVC, backGround: backGround, textColor: textColor, buttonColor: buttonBackGround)
                }
            }
        }


    @IBAction func unwindWordList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! WordDetailTableViewController
        
        if let word = sourceViewController.word {
            if let indexOfExistingWord = words.firstIndex(of: word) {
                words[indexOfExistingWord] = word
                words.sort { word1, word2 in
                    return word1.englishWord < word2.englishWord
                }
                tableView.reloadData()
                if let indexOfFilterWord = filteredWord.firstIndex(of: word) {
                    filteredWord[indexOfFilterWord] = word
                    tableView.reloadData()
                }
            } else {
                let newIndexPath = IndexPath(row: words.count, section: 0)
                words.append(word)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                words.sort { word1, word2 in
                    return word1.englishWord < word2.englishWord
                }
                tableView.reloadData()
            }
            
        }
        
        Word.saveWords(words)
    }
    
    
    
    
    @IBSegueAction func editWord(_ coder: NSCoder, sender: Any?) -> WordDetailTableViewController? {
        let detailController = WordDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return detailController }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isSearching {
            detailController?.word = filteredWord[indexPath.row]
            return detailController
        } else {
            detailController?.word = words[indexPath.row]
            return detailController
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredWord.count : words.count
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as! WordTableViewCell
        
        cell.englishWordLabel.textColor = textColor.1
        cell.russianWordLabel.textColor = textColor.1
        cell.englishWordLevelLabel.textColor = textColor.1
        if isSearching {
            
            let filteredWord = filteredWord[indexPath.row]
            
            cell.englishWordLabel.text = filteredWord.englishWord
            cell.russianWordLabel.text = filteredWord.russianWord
            cell.englishWordLevelLabel.text = filteredWord.wordLevel
            return cell
        } else {
            
            let word = words[indexPath.row]
            cell.englishWordLabel.text = word.englishWord
            cell.russianWordLabel.text = word.russianWord
            cell.englishWordLevelLabel.text = word.wordLevel
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            navigationItem.leftBarButtonItem?.title = "Готово"
        } else {
            navigationItem.leftBarButtonItem?.title = "Редактировать"
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isSearching {
                deleteWord(at: indexPath)
                Word.saveWords(words)
            } else {
                words.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                Word.saveWords(words)
            }
            navigationItem.leftBarButtonItem?.title = "Готово"
        }
    }
}

extension WordTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredWord.removeAll()
        
        guard searchText != "" || searchText != " " else {return}
        
        if searchBar.text == "" || searchBar.text == " " {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            let searchText = searchBar.text ?? ""
            filteredWord = words.filter { word in
                return word.russianWord.lowercased().contains(searchText.lowercased()) ||
                word.englishWord.lowercased().contains(searchText.lowercased())
            }
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension WordTableViewController {

    private func configure() {
        //изменение цвета NavBar чтобы при скроллинге он не изменялся
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Resources.Colors.Beige.backGroundView
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = Resources.Colors.Beige.barTextColor
        
        view.backgroundColor = Resources.Colors.Beige.backGroundView
    }
    
    func configureColorsAuditVC(VC: UIViewController, backGround: UIColor, textColor: (button: UIColor, label: UIColor, navButton: UIColor), buttonColor: UIColor) {
        if let vc = VC as? WordDetailTableViewController {
            
            vc.view.backgroundColor = backGround
    
            vc.navigationItem.rightBarButtonItem?.tintColor = textColor.navButton
            vc.navigationItem.leftBarButtonItem?.tintColor = textColor.navButton
            
            vc.addImageButton.tintColor = textColor.button
            vc.addImageButton.backgroundColor = buttonColor
            
            vc.englishWordLevelSegmentedController.selectedSegmentTintColor = buttonColor
            vc.englishWordLevelSegmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColor.button], for: .selected)
        }
    }
}

