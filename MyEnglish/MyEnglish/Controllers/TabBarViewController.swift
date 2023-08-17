//
//  TabBarViewController.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 24.07.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Изменяем цвет TabBar чтобы он не становился белым при скроллинге
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 1, green: 0.945, blue: 0.882, alpha: 1)
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
