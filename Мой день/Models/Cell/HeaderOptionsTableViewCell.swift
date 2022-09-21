//
//  HeaderOptionsCheduleTableViewCell.swift
//  Мой день
//
//  Created by Nikita Skripka on 25.08.2022.
//

import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {

    private let headerLabel = UILabel(text: "", font: .avenirNext14(), color: .black)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        headerLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.contentView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderOptionsTableViewCell {
    
    func headerConfigure(nameArray: [String], section: Int) {
       headerLabel.text = nameArray[section]
    }
    
    private func setConstraints() {
        
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
