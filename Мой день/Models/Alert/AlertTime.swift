//
//  AlertTime.swift
//  Мой день
//
//  Created by Nikita Skripka on 26.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertTime(label: UILabel, completionHendler: @escaping (Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let timeString = dateFormater.string(from: datePicker.date)
            let timeSchedule = datePicker.date
            completionHendler(timeSchedule)
            
            label.text = timeString
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true)
    }
}
