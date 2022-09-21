//
//  UILabel.swift
//  Мой день
//
//  Created by Nikita Skripka on 23.08.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, color: UIColor = .black, aligment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = aligment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
