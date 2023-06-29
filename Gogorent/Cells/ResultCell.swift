//
//  ResultCell.swift
//  Gogorent
//
//  Created by Alex Lin Work on 2023/6/29.
//

import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var colors: [UIColor] = [] {
        didSet {
            if oldValue != colors {
                updateResults()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func updateResults() {
        // Clean
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        // Create
        for color in colors {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = color
            view.layer.cornerRadius = 8.0
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.text = "房源"
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 115.0),
                view.heightAnchor.constraint(equalToConstant: 120.0),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            
            stackView.addArrangedSubview(view)
        }
    }
}
