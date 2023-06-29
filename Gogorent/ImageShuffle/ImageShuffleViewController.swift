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
    
    private var transitionCard: SwipeCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
        setUpUI()
    }
    
    private func setUpData() {
        rooms = Room.createRandomRooms()
    }
    
    private func setUpUI() {
        view.addSubview(cardStack)
        view.backgroundColor = .white
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            cardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            cardStack.heightAnchor.constraint(equalTo: cardStack.widthAnchor, multiplier: 1.1)
        ])
            
        cardStack.delegate = self
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
        card.content = cardView
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: card.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: card.bottomAnchor)
        ])
        
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

extension ImageShuffleViewController: SwipeCardStackDelegate {
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        
        transitionCard = cardStack.card(forIndexAt: index)
        
        let roomDetailViewController = RoomDetailViewController(room: rooms[index], imageHeight: transitionCard?.frame.height ?? 0)
        roomDetailViewController.modalPresentationStyle = .overFullScreen
        roomDetailViewController.transitioningDelegate = self
        present(roomDetailViewController, animated: true)
    }
}

extension ImageShuffleViewController: CardTransitionAnimatorPresenting {
    func transitionViewRect() -> CGRect? {
        guard let card = transitionCard else {
            return nil
        }
        
        var frame = card.superview?.convert(card.frame, to: view)
        
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        frame?.origin.y += topPadding
        
        return frame
    }
    
    func transitionView() -> UIView? {
        transitionCard
    }
}

extension ImageShuffleViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardTransitionAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardTransitionAnimator()
    }
}
