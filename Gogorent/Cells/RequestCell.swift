//
//  RequestCell.swift
//  Gogorent
//
//  Created by Alex Lin Work on 2023/6/29.
//

import UIKit

class RequestCell: UITableViewCell {
    
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        requestLabel.textColor = .white
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0)
        stackView.layer.cornerRadius = 8.0
        stackView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
