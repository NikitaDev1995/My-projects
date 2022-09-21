//
//  OptionsScheduleTableViewCell.swift
//  Мой день
//
//  Created by Nikita Skripka on 25.08.2022.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

     let backGroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let nameCellLabel: UILabel = {
       var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    weak var switchRepeatDelegate: SwitchRepeatProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        switchRepeatDelegate?.switchRepeat(value: paramTarget.isOn)
    }
}

extension OptionsTableViewCell {
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath, hexColor: String) {
        
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        
        let color = UIColor().colorFromHex(hexColor)
        backGroundViewCell.backgroundColor = indexPath.section == 3 ? color : .white
        
        repeatSwitch.isHidden = indexPath == [4,0] ? false : true
        repeatSwitch.onTintColor = color
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath, hexColor: String) {
        nameCellLabel.text = nameArray[indexPath.section]
        let color = UIColor().colorFromHex(hexColor)
        backGroundViewCell.backgroundColor = indexPath == [3,0] ? color : .white
    }
    
    func cellContactConfigure(nameArray: [String], indexPath: IndexPath, image: UIImage?) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        if image == nil {
            backGroundViewCell.image = (indexPath.section == 4 ? UIImage(systemName: "person.fill.badge.plus") : nil)
        } else {
            backGroundViewCell.image = (indexPath.section == 4 ? image : nil)
            backGroundViewCell.contentMode = .scaleAspectFill
        }
    }

    private func setConstraints() {
        
        self.addSubview(backGroundViewCell)
        NSLayoutConstraint.activate([
            backGroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backGroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backGroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backGroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
        backGroundViewCell.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: backGroundViewCell.centerYAnchor, constant: 0),
            nameCellLabel.leadingAnchor.constraint(equalTo: backGroundViewCell.leadingAnchor, constant: 15)
        ])
        
        contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: backGroundViewCell.centerYAnchor, constant: 0),
            repeatSwitch.trailingAnchor.constraint(equalTo: backGroundViewCell.trailingAnchor, constant: -15)
        ])
    }
}
