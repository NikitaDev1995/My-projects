//
//  AlertFriendsOrTeachers.swift
//  Мой день
//
//  Created by Nikita Skripka on 30.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertFriendOrTeacher(label: UILabel, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let friend = UIAlertAction(title: "Friend", style: .default) { (_) in
            label.text = "Friend"
            let typeContact = "Friend"
            completionHandler(typeContact)
        }
        
        let teacher = UIAlertAction(title: "Teacher", style: .default) { (_) in
            label.text = "Teacher"
            let typeContact = "Teacher"
            completionHandler(typeContact)
        }
        
        let cancle = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(friend)
        alertController.addAction(teacher)
        alertController.addAction(cancle)
        
        present(alertController, animated: true, completion: nil)
    }
}

