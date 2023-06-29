//
//  UserInputCell.swift
//  Gogorent
//
//  Created by Alex Lin Work on 2023/6/29.
//

import UIKit

class UserInputCell: UITableViewCell {
    
    @IBOutlet weak var userInputLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0)
        stackView.layer.cornerRadius = 8.0
        stackView.backgroundColor = .systemGreen
        
        userInputLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
