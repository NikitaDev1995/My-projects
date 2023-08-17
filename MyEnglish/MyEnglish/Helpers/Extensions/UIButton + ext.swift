//
//  UIButton + ext.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 02.08.2023.
//

import UIKit

extension UIButton {
    func setText(_ text: String) {
        if let font = titleLabel?.font {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font
            ]
            let attributedTitle = NSAttributedString(string: text, attributes: attributes)
            
            setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}
