//
//  Bank.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.07.2022.
//

import Foundation
import UIKit



class Bank {
    enum CardOrLoan {
        case card
        case loan
    }
    var name: String
    var image: UIImage
    var type: CardOrLoan
    var mounth: (String, String, String)
    init(name: String, image: UIImage, type: CardOrLoan, mounth: (String, String, String)) {
        self.name = name
        self.image = image
        self.type = type
        self.mounth = mounth
    }
}
