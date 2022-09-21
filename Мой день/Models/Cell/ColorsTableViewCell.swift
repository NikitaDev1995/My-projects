//
//  ColorScheduleTableViewCell.swift
//  Мой день
//
//  Created by Nikita Skripka on 29.08.2022.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {

    private let backGroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {
        switch indexPath.section {
        case 0: backGroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
        case 1: backGroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        case 2: backGroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.9843137255, blue: 0, alpha: 1)
        case 3: backGroundViewCell.backgroundColor = #colorLiteral(red: 0, green: 0.9764705882, blue: 0, alpha: 1)
        case 4: backGroundViewCell.backgroundColor = #colorLiteral(red: 0, green: 0.9921568627, blue: 1, alpha: 1)
        case 5: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.2, blue: 1, alpha: 1)
        default: backGroundViewCell.backgroundColor = .purple
        }
    }
}

extension ColorsTableViewCell {
    
    private func setConstraints() {
        
        self.addSubview(backGroundViewCell)
        NSLayoutConstraint.activate([
            backGroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backGroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backGroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backGroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
    }
}
