//
//  ContactModel.swift
//  Мой день
//
//  Created by Nikita Skripka on 18.09.2022.
//

import Foundation
import RealmSwift

class ContactModel: Object {
    
    @Persisted var contactName: String = "Unknown"
    @Persisted var contactPhone: String = "Unknown"
    @Persisted var contactMail: String = "Unknown"
    @Persisted var contactType: String = "Unknown"
    @Persisted var contactImage: Data?
}
