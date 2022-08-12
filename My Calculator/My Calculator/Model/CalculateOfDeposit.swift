//
//  Calculate.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.06.2022.
//

import Foundation

class CalculatorOfDeposit {
    
        var depositAmount: String
        var percent: String
        var countOfDays: String
    
        var calculateOfProfitable: String {
                if let a = Double(depositAmount), percent != "", let b = Double(countOfDays) {
                    return String(a * Double(percent.doubleValue) * b / 365 / 100)
            }
            return "Введите корректные числа"
            }

    var  calculateMonthlyAmount: String {
        if let a = Double(depositAmount), percent != "", let b = Double(countOfDays) {
            return String(a / Double(percent.doubleValue) / b * 365 * 100)
        }
        return "Введите корректные числа"
        }
    
    init(depositAmount: String, percent: String, countOfDays: String) {
        self.depositAmount = depositAmount
        self.percent = percent
        self.countOfDays = countOfDays
    }
}

