//
//  CalculateOfInstallment.swift
//  My Calculator
//
//  Created by Nikita Skripka on 04.08.2022.
//

import Foundation

class CalculateOfInstallment {
    let installment: String
    let countOfMounth: String
    let bank: Bank
    var calculateOfInstallment: Double {
        get {
             switch countOfMounth {
            case "6":
                 return (Double(installment) ?? 0) - ((Double(installment) ?? 0) * (Double(bank.mounth.0) ?? 0) / 100)
            case "12":
                 return (Double(installment) ?? 0) - ((Double(installment) ?? 0) * (Double(bank.mounth.1) ?? 0) / 100)
            case "18":
                 return (Double(installment) ?? 0) - ((Double(installment) ?? 0) * (Double(bank.mounth.2) ?? 0) / 100)
            default:
                break
            }
            return 0
        }
    }
    init(installment: String, countOfMounth: String, bank: Bank) {
        self.installment = installment
        self.countOfMounth = countOfMounth
        self.bank = bank
    }
}
