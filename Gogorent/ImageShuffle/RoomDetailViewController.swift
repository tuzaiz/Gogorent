//
//  RoomDetailViewController.swift
//  Gogorent
//
//  Created by ClydeHsieh on 2023/6/29.
//

import UIKit

final class RoomDetailViewController: UIViewController {
    private let room: Room
    private let imageHeight: CGFloat
    private var labelStackView: UIStackView?
    
    init(room: Room, imageHeight: CGFloat) {
        self.room = room
        self.imageHeight = imageHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUp()
    }
    
    private func setUp() {
        let roomImage = UIImage(named: room.imageName)
        let ratio = roomImage!.size.width / roomImage!.size.height
        let imageView = UIImageView(image: roomImage)
        
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: ratio)
        ])
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.text = room.title
        titleLabel.textColor = .darkGray
        
        let contentLabel = UILabel()
        contentLabel.font = .systemFont(ofSize: 20)
        contentLabel.text = room.description
        contentLabel.textColor = .darkGray
        contentLabel.numberOfLines = 0
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        view.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.alpha = 0
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        self.labelStackView = labelStackView
        
        let xImage = UIImage(systemName: "xmark.circle.fill")?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 20)))
        let closeButton = UIButton()
        closeButton.setImage(xImage, for: .normal)
        closeButton.tintColor = .darkGray
        closeButton.addAction(.init(handler: { _ in
            self.dismiss(animated: true)
        }), for: .primaryActionTriggered)
        
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            self.labelStackView?.alpha = 1
        }
    }
}
