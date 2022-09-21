//
//  AlertForCellName.swift
//  Мой день
//
//  Created by Nikita Skripka on 26.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertForCellName(label: UILabel, name: String, placeholder: String, complition: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else {return}
            if text != "" {
                label.text = text
            }
            complition(text)
        }
        
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
