//
//  File.swift
//  MyApplication
//
//  Created by Nikita Skripka on 27.04.2022.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set }
    var phone: String {get set }
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}


