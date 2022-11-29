//
//  CustomNavBar.swift
//  AppMusicBF
//
//  Created by user218997 on 25/11/22.
//

import UIKit

class CustomNavBar: UIView {
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var cardTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var featureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.7)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(cardImage)
        addSubview(overlayView)
        addSubview(categoryTitleLabel)
        addSubview(cardTitleLabel)
        addSubview(featureLabel)
    }
    
    private func setUpConstraints() {
        cardImage.pin(to: self)
        overlayView.pin(to: self)
        
        NSLayoutConstraint.activate([
            
            categoryTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            cardTitleLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor),
            cardTitleLabel.trailingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor),
            cardTitleLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 5),
            
            featureLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor),
            featureLabel.trailingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor),
            featureLabel.topAnchor.constraint(equalTo: cardTitleLabel.bottomAnchor, constant: 5)
            
        ])
    }
    
    public func setUpView(data: CardViewModel) {
        cardTitleLabel.text = data.cardTitle
        categoryTitleLabel.text = data.categoryName
        cardImage.image = UIImage(named: data.cardImage ?? "")
        featureLabel.attributedText = .featureText(data.likeCount ?? "", data.duration ?? "")
    }
    
}
