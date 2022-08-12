//
//  BankTableViewCell.swift
//  My Calculator
//
//  Created by Nikita Skripka on 28.07.2022.
//

import UIKit

class BankTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var bankLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
