//
//  Theme.swift
//  My Calculator
//
//  Created by Nikita Skripka on 03.08.2022.
//

import UIKit

protocol ThemeProtocol {
    var backGorundColor: UIColor { get }
    var textColor: UIColor { get }
    var cellColor: UIColor { get }
}

class Theme {
    static var currentTheme: ThemeProtocol = LightTheme()
}
