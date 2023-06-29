//
//  ResultCell.swift
//  Gogorent
//
//  Created by Alex Lin Work on 2023/6/29.
//

import UIKit

class ResultCell: UITableViewCell {
    
    private var loadingContentView: UIView!
    private var loadingView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    private(set) var isLoading: Bool = false
    
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
        
        loadingContentView = UIView()
        loadingContentView.translatesAutoresizingMaskIntoConstraints = false
        loadingContentView.backgroundColor = .white
        loadingContentView.isHidden = true
        
        loadingView = UIView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingContentView)
        loadingContentView.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            loadingContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loadingContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loadingContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: loadingContentView.topAnchor, constant: 8.0),
            loadingView.leadingAnchor.constraint(equalTo: loadingContentView.leadingAnchor, constant: 16.0),
            loadingView.widthAnchor.constraint(equalToConstant: 100.0),
            loadingView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
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
    
    // baseline = to put the bottom of the dots at the baseline of the text in the label
    // dotXOffset = gap between end of label and first dot
    // dotSize = dot width and height
    // dotSpacing = gap between dots
    private func showAnimatingDotsInImageView(dotsView: UIView, baseline: CGFloat, dotXOffset: CGFloat, dotSize: CGFloat, dotSpacing: CGFloat) {
        let lay = CAReplicatorLayer()
        let bar = CALayer()
        bar.frame = CGRect(x: dotXOffset, y: baseline - dotSize, width: dotSize, height: dotSize)
        bar.cornerRadius = bar.frame.width / 2  // we want round dots
        bar.backgroundColor = UIColor.black.cgColor
        lay.addSublayer(bar)
        lay.instanceCount = 3   //How many instances / objs do you want to see
        lay.instanceTransform = CATransform3DMakeTranslation(dotSpacing, 0, 0) //1st arg is the spacing between the instances
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        bar.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        dotsView.layer.addSublayer(lay)    // add to the view
    }
    
    func playLoadingAnimation() {
        loadingContentView.isHidden = false
        
        showAnimatingDotsInImageView(dotsView: loadingView, baseline: 0.0, dotXOffset: 0.0, dotSize: 8.0, dotSpacing: 12.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            loadingContentView.isHidden = true
        }
    }
}
