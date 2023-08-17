//
//  SettingsTableViewController.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 05.07.2023.
//

import UIKit
import UserNotifications

class SettingsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var themeTableVIewCell: UITableViewCell!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationDatePicker: UIDatePicker!
    @IBOutlet weak var themeStackView: UIStackView!
    @IBOutlet var modeButtons: [UIButton]!
    
    //MARK: - Properties
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let checkInThemeCellIndexPath = IndexPath(row: 1, section: 0)
    var isCheckInThemeStackViewVisible: Bool = false {
        didSet {
            themeStackView.isHidden = !isCheckInThemeStackViewVisible
        }
    }
    
    let checkNotificationDataPickerIndexPath = IndexPath(row: 1, section: 1)
    var isCheckInDataPickerVisible: Bool = false {
        didSet {
            notificationDatePicker.isHidden = !isCheckInDataPickerVisible
        }
    }
    
    
    
    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureButtons(modeButtons)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //отключение switch выходе на главный экран устройства
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Methods
    
    @objc func appMovedToBackground() {
        notificationSwitch.isOn = false
    }
    
    private func themeAppearance(backGroundColor: UIColor, backGroundButtonColor: UIColor, labelTextColor: UIColor, tabBarTextColor: UIColor, buttonTextColor: UIColor ) {
        let navController = self.tabBarController?.viewControllers![0] as! UINavigationController
        let navController2 = self.tabBarController?.viewControllers![1] as! UINavigationController
        
        guard let englishLevelTableViewController = navController.topViewController as? EnglishLevelTableViewController, let wordTableViewController = navController2.topViewController as? WordTableViewController else {return}
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = backGroundColor
        tabBarController?.tabBar.tintColor = tabBarTextColor
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarController?.tabBar.standardAppearance
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = backGroundColor
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        themeTableVIewCell.textLabel?.textColor = labelTextColor
        notificationLabel.textColor = labelTextColor
        view.backgroundColor = backGroundColor
        
        wordTableViewController.view.backgroundColor = backGroundColor
        wordTableViewController.navigationItem.leftBarButtonItem?.tintColor = tabBarTextColor
        wordTableViewController.navigationItem.rightBarButtonItem?.tintColor = tabBarTextColor
        wordTableViewController.navigationBarAppearance.configureWithOpaqueBackground()
        wordTableViewController.navigationBarAppearance.backgroundColor = backGroundColor
        wordTableViewController.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        wordTableViewController.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        wordTableViewController.searchBar.barTintColor = backGroundColor
        wordTableViewController.updateCustomCellProperties(textColor: labelTextColor)
        wordTableViewController.buttonBackGround = backGroundButtonColor
        wordTableViewController.textColor = (button: buttonTextColor, label: labelTextColor, navButton: tabBarTextColor)
        wordTableViewController.backGround = backGroundColor
        
        englishLevelTableViewController.view.backgroundColor = backGroundColor
        englishLevelTableViewController.navigationBarAppearance.configureWithOpaqueBackground()
        englishLevelTableViewController.navigationBarAppearance.backgroundColor = backGroundColor
        englishLevelTableViewController.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        englishLevelTableViewController.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        englishLevelTableViewController.backGroundButton = backGroundButtonColor
        englishLevelTableViewController.textColor = (button: buttonTextColor, label: labelTextColor, navButton: tabBarTextColor)
        englishLevelTableViewController.backGroundMainView = backGroundColor
    }
    
    //MARK: - IBActions
    
    @IBAction func classicModeButtonAction(_ sender: UIButton) {
        themeAppearance(backGroundColor: Resources.Colors.White.backGroundView, backGroundButtonColor: Resources.Colors.White.backGroundButton, labelTextColor: Resources.Colors.White.labelTextColor, tabBarTextColor: Resources.Colors.White.barTextColor, buttonTextColor: Resources.Colors.White.buttonTextColor)
    }
    
    @IBAction func beigeModeButtonAction(_ sender: UIButton) {
        themeAppearance(backGroundColor: Resources.Colors.Beige.backGroundView, backGroundButtonColor: Resources.Colors.Beige.backGroundButton, labelTextColor: Resources.Colors.Beige.labelTextColor, tabBarTextColor: Resources.Colors.Beige.barTextColor, buttonTextColor: Resources.Colors.Beige.buttonTextColor)
        
    }
    
    @IBAction func yellowModeButtonAction(_ sender: UIButton) {
        themeAppearance(backGroundColor: Resources.Colors.Yellow.backGroundView, backGroundButtonColor: Resources.Colors.Yellow.backGroundButton, labelTextColor: Resources.Colors.Yellow.labelTextColor, tabBarTextColor: Resources.Colors.Yellow.barTextColor, buttonTextColor: Resources.Colors.Yellow.buttonTextColor)
    }
    
    
    @IBAction func notificationSwitch(_ sender: UISwitch) {
    
            notificationCenter.requestAuthorization(options: [.alert, .sound]) { (permissionGranted, error) in
                if !permissionGranted {
                    print("Permission Denied")
                }
            }
            
            notificationCenter.getNotificationSettings { (settings) in
                
                DispatchQueue.main.async {
                    let title = "Уведомление"
                    let message = "Запланирован урок английского"
                    let date = self.notificationDatePicker.date
                    
                    if settings.authorizationStatus == .authorized {
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.body = message
                        content.sound = .default
                        
                        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        self.notificationCenter.add(request) { (error) in
                            if error != nil {
                                print("Error " + error.debugDescription)
                                return
                            }
                        }
                    }
                }
            }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
        
        //MARK: - Table view delegate
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath {
            case checkInThemeCellIndexPath where isCheckInThemeStackViewVisible == false:
                return 0
            case checkNotificationDataPickerIndexPath where isCheckInDataPickerVisible == false:
                return 0
            default:
                return UITableView.automaticDimension
            }
        }
        
        override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath {
            case checkInThemeCellIndexPath:
                return 167
            case checkNotificationDataPickerIndexPath:
                return 190
            default:
                return UITableView.automaticDimension
            }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath == IndexPath(row: 0, section: 0) {
                isCheckInThemeStackViewVisible.toggle()
            } else if indexPath == IndexPath(row: 0, section: 1) {
                isCheckInDataPickerVisible.toggle()
            } else {
                return
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
extension SettingsTableViewController {

    private func configure() {
        //изменение цвета NavBar чтобы при скроллинге он не изменялся
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 1, green: 0.945, blue: 0.882, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        view.backgroundColor = Resources.Colors.Beige.backGroundView
    }
    
    private func configureButtons(_ buttonsArray: [UIButton]) {
        buttonsArray.forEach { button in
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
        }
    }
}
