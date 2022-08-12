//
//  ModelBank.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.07.2022.
//

import Foundation
import UIKit

class ModelBank {
    var banks: [[Bank]] = []
    init () {
        setup()
    }
    func setup() {
        let bank1 = Bank(name: "OTP", image: UIImage(named: "Otp")!, type: .loan, mounth: ("4.5", "8.5", "9") )
        let bank2 = Bank(name: "Совкомбанк", image: UIImage(named: "Sovkombank")!, type: .loan, mounth: ("4.5", "8.5", "8.5"))
        let bank3 = Bank(name: "Почтабанк", image: UIImage(named: "Pochta")!, type: .loan, mounth: ("4.5", "8.5", "7.5"))
        let bank4 = Bank(name: "МТС", image: UIImage(named: "mtc")!, type: .loan, mounth: ("3", "8.5", "9"))
        let bank5 = Bank(name: "РенеСанс Кредит", image: UIImage(named: "renensans")!, type: .loan, mounth: ("4.5", "8.5", "11"))
        let bank6 = Bank(name: "Кредит Европа", image: UIImage(named: "evropa")!, type: .loan, mounth: ("4.5", "8.5", "7.5"))
        let loanArray:[Bank] = [bank1, bank2, bank3, bank4, bank5, bank6]
        banks.append(loanArray)
    }
}
