//
//  CardView.swift
//  Gogorent
//
//  Created by ClydeHsieh on 2023/6/29.
//

import UIKit

final class CardView: UIView {

    private let room: Room
    
    init(room: Room) {
        self.room = room
        
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        let imageView = UIImageView(image: UIImage(named: room.imageName))
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let bioBackground = UIView()
        bioBackground.backgroundColor = .lightGray
        bioBackground.alpha = 0.8
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.text = room.title
        titleLabel.textColor = .white
        
        let contentLabel = UILabel()
        contentLabel.font = .systemFont(ofSize: 20)
        contentLabel.text = room.description
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 0
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        addSubview(bioBackground)
        addSubview(labelStackView)
        bioBackground.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bioBackground.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor),
            bioBackground.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            bioBackground.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bioBackground.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            labelStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        clipsToBounds = true
        layer.cornerRadius = 40
    }
}
