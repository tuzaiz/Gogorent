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
    
    var imageNames: [String] = [] {
        didSet {
            if oldValue != imageNames {
                updateResults()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        resultLabel.textColor = .white
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
        for imageName in imageNames {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 8.0
            view.clipsToBounds = true
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            view.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 115.0),
                view.heightAnchor.constraint(equalToConstant: 120.0),
                imageView.topAnchor.constraint(equalTo: view.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            stackView.addArrangedSubview(view)
        }
    }
}
