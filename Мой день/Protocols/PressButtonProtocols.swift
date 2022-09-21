//
//  PressButtonProtocols.swift
//  Мой день
//
//  Created by Nikita Skripka on 24.08.2022.
//

import Foundation

protocol PressReadyTaskButtonProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}

protocol SwitchRepeatProtocol: AnyObject {
    func switchRepeat(value: Bool)
}
