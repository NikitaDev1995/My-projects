//
//  CalculateOfLoan.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.06.2022.
//

import Foundation

class CalculateOfLoan {
    var percent: String
    var loan: String
    var countOfMounth: String
    
    var differentiatedSettlement: String {
        if percent != "", let b = Double(loan), let c = Double(countOfMounth) {
            return String(b / c + b * (Double(percent.doubleValue) / 100 / 12))
        }
        return "Введите корректные данные"
    }
    
    var annuityCalculation: String {
        if percent != "", let b = Double(loan), let c = Double(countOfMounth) {
            let percentLoan = Double(percent.doubleValue) / 100 / 12
            return String(b * (percentLoan + (percentLoan / (pow(1 + percentLoan, c) - 1))))
        }
        return "Введите корректные данные"
    }
    
    init(percent: String, loan: String, countOfMounth: String) {
        self.percent = percent
        self.loan = loan
        self.countOfMounth = countOfMounth
    }
    
}


