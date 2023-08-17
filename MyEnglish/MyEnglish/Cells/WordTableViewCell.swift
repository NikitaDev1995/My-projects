//
//  WordTableViewCell.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 29.06.2023.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var russianWordLabel: UILabel!
    @IBOutlet weak var englishWordLabel: UILabel!
    @IBOutlet weak var englishWordLevelLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension WordTableViewCell {
    private func setupAppearanceLabel(label: UILabel) {
        label.textColor = Resources.Colors.Beige.labelTextColor
        label.font = Resources.Fonts.font(size: 18)
    }
    
    private func configure() {
        backgroundColor = .clear
        setupAppearanceLabel(label: russianWordLabel)
        setupAppearanceLabel(label: englishWordLabel)
        setupAppearanceLabel(label: englishWordLevelLabel)
    }
}
