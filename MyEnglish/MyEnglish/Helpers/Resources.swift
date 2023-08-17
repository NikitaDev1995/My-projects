//
//  Resources.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 21.07.2023.
//

import UIKit

enum Resources {
    
    enum Colors {
        enum Beige {
            static let backGroundView = UIColor(hexString: "#FFF1E1")
            static let backGroundButton = UIColor(hexString: "#EF6C41")
            static let buttonTextColor = UIColor(hexString: "#1E3D59")
            static let labelTextColor = UIColor(hexString: "#1E3D59")
            static let barTextColor = UIColor(hexString: "#1E3D59")
        }
        enum White {
            static let backGroundView = UIColor.systemBackground
            static let backGroundButton = UIColor.systemBlue
            static let buttonTextColor = UIColor.white
            static let labelTextColor = UIColor.black
            static let barTextColor = UIColor.systemBlue
        }
        enum Yellow {
            static let backGroundView = UIColor(hexString: "#FBB917")
            static let backGroundButton = UIColor(hexString: "#A52A2A")
            static let buttonTextColor = UIColor(hexString: "#FBB917")
            static let labelTextColor = UIColor.black
            static let barTextColor = UIColor.black
        }
    }
    
    enum Fonts {
        static func font(size: CGFloat) -> UIFont {
            UIFont(name: "HelveticaNeue-Bold", size: size) ?? UIFont()
        }
    }
}
