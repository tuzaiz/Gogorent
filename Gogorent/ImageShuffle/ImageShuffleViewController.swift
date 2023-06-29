//
//  ImageShuffleViewController.swift
//  Gogorent
//
//  Created by ClydeHsieh on 2023/6/29.
//

import UIKit
import Shuffle

final class ImageShuffleViewController: UIViewController {
    private let cardStack = SwipeCardStack()
    private var rooms: [Room] = []
    private let controlBar = UIStackView()
    
    private let cardSize: CGSize = .init(width: 360, height: 400)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
        setUpUI()
    }
    
    private func setUpData() {
        for index in 1...7 {
            rooms.append(.init(imageName: "room\(index)", title: "Room \(index)", description: "This is room \(index)"))
        }
    }
    
    private func setUpUI() {
        view.addSubview(cardStack)
        view.backgroundColor = .white
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            cardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardStack.widthAnchor.constraint(equalToConstant: cardSize.width),
            cardStack.heightAnchor.constraint(equalToConstant: cardSize.height)
        ])
            
        cardStack.dataSource = self
        
        let heartImage = UIImage(systemName: "heart.fill")?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 50)))
        let likeButton = UIButton()
        likeButton.setImage(heartImage, for: .normal)
        likeButton.tintColor = .red
        likeButton.addAction(.init(handler: { _ in
            self.swipToLike()
        }), for: .primaryActionTriggered)
        
        let xImage = UIImage(systemName: "x.circle")?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 50)))
        let unlikeButton = UIButton()
        unlikeButton.setImage(xImage, for: .normal)
        unlikeButton.tintColor = .darkGray
        unlikeButton.addAction(.init(handler: { _ in
            self.swipToUnlike()
        }), for: .primaryActionTriggered)
        
        controlBar.addArrangedSubview(unlikeButton)
        controlBar.addArrangedSubview(likeButton)
        controlBar.spacing = 100
        controlBar.distribution = .fillEqually
        
        view.addSubview(controlBar)
        controlBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controlBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            controlBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func card(from room: Room) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
        let cardView = CardView(room: room)
        cardView.frame = .init(origin: .zero, size: cardSize)
        card.content = cardView
        
        return card
    }
    
    private func swipToLike() {
        cardStack.swipe(.right, animated: true)
    }
    
    private func swipToUnlike() {
        cardStack.swipe(.left, animated: true)
    }
}


extension ImageShuffleViewController: SwipeCardStackDataSource {
    func cardStack(_ cardStack: Shuffle.SwipeCardStack, cardForIndexAt index: Int) -> Shuffle.SwipeCard {
        card(from: rooms[index])
    }
    
    func numberOfCards(in cardStack: Shuffle.SwipeCardStack) -> Int {
        rooms.count
    }
}
