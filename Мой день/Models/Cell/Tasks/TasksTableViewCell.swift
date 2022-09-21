//
//  TasksTableViewCell.swift
//  Мой день
//
//  Created by Nikita Skripka on 24.08.2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    private let taskName = UILabel(text: "", font: .avenirNext20(), color: .black)
    private let taskDescription = UILabel(text: "", font: .avenirNext14(), color: .black)
    private let taskDate = UILabel(text: "", font: .avenirNextDemiBold20(), color: .black)
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyTaskButtonProtocol?
    
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCounstraints()
        
        self.selectionStyle = .none
        
        taskDescription.numberOfLines = 2
        
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TasksModel) {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        guard let time = model.tasksDate else {
            return
        }
        taskDate.text = dateFormater.string(from: time)
        taskName.text = model.tasksLesson
        taskDescription.text = model.tasksTask
        backgroundColor = UIColor().colorFromHex("\(model.tasksColor)")
        
        if model.taskReady {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    @objc func readyButtonTapped() {
        guard let index = index else {
            return
        }
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
}
}

extension TasksTableViewCell {
    
    private func setCounstraints() {
        
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40)
        ])
      
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            //taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskDate)
        NSLayoutConstraint.activate([
            taskDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskDate.leadingAnchor.constraint(equalTo: taskName.trailingAnchor, constant: 20)
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
