//
//  ContactsTableViewCell.swift
//  Мой день
//
//  Created by Nikita Skripka on 29.08.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    var contactImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill //правильно растягивает изображение
        imageView.clipsToBounds = true //обрезать ненужные края
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let phoneImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")
        imageView.tintColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel = UILabel(text: "", font: .avenirNext20())
    private let phoneLabel = UILabel(text: "", font: .avenirNext14())
    private let mailLabel = UILabel(text: "", font: .avenirNext14())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContactModel) {
        nameLabel.text = model.contactName
        phoneLabel.text = model.contactPhone
        mailLabel.text = model.contactMail
        if let data = model.contactImage, let image = UIImage(data: data) {
            contactImageView.image = image
        } else {
            contactImageView.image = UIImage(systemName: "person.fill")
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutSubviews()
        
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
}

extension ContactsTableViewCell {
    
    
    private func setConstraints() {
        
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contactImageView.heightAnchor.constraint(equalToConstant: 70),
            contactImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}
