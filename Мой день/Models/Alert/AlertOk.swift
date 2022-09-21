//
//  AlertOk.swift
//  Мой день
//
//  Created by Nikita Skripka on 02.09.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertOk (title: String, message: String?) {
        
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
