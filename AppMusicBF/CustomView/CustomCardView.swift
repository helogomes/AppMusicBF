//
//  CustomCardView.swift
//  AppMusicBF
//
//  Created by user218997 on 18/11/22.
//

import UIKit

enum ViewMode {
    case full
    case card
}

class CustomCardView: UIView {
    
    //MARK: - PROPRIEDADES
    var containerLeadingConstraints: NSLayoutConstraint?
    var containerTraillingingConstraints: NSLayoutConstraint?
    var containerTopConstraints: NSLayoutConstraint?
    var containerBottomConstraints: NSLayoutConstraint?
    var dataModel: CardViewModel?
    
    //MARK: - ELEMENTOS
    
    //view do card
    lazy var cardContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 20
        return view
    }()
    
    //imagem sobre o card como um todo
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        return image
    }()
    
    //view que escurece a imagem do card
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    //bordas que ficam sob a imagem de perfil
    lazy var profileBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
        return view
    }()

    //imagem de perfil
    lazy var cardProfilePicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    //botão de adicionar imagem do usuario (plus)
    lazy var addProfileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    //categoria da musica
    lazy var cardCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    //data categoria
    lazy var cardCategoryDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    //titulo
    lazy var cardTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //gostei e tempo
    lazy var likeAndTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //descrição do titulo
    lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var actionsView: CardActionView = {
        let view = CardActionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(mode: ViewMode) {
        let frame = CGRect.zero
        super.init(frame: frame)
        addSubViews()
        setUpConstraints()
        updateLayout(for: mode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(cardContainerView)
        cardContainerView.addSubview(cardImage)
        cardContainerView.addSubview(overlayView)
        cardContainerView.addSubview(profileBorderView)
        cardContainerView.addSubview(cardProfilePicture)
        cardContainerView.addSubview(addProfileImageButton)
        cardContainerView.addSubview(cardCategoryTitleLabel)
        cardContainerView.addSubview(cardCategoryDateLabel)
        cardContainerView.addSubview(cardTitleLabel)
        cardContainerView.addSubview(likeAndTimeLabel)
        cardContainerView.addSubview(descriptionTitleLabel)
        cardContainerView.addSubview(actionsView)
    }
    
    private func setUpConstraints() {
        
        containerLeadingConstraints = cardContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        containerLeadingConstraints?.isActive = true
        
        containerTopConstraints = cardContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        containerTopConstraints?.isActive = true
        
        containerBottomConstraints = cardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        containerBottomConstraints?.isActive = true
        
        containerTraillingingConstraints = cardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        containerTraillingingConstraints?.isActive = true
        
        overlayView.pin(to: cardContainerView)
        cardImage.pin(to: cardContainerView)
        
        NSLayoutConstraint.activate([
            profileBorderView.topAnchor.constraint(equalTo: cardContainerView.topAnchor, constant: 60),
            profileBorderView.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            profileBorderView.widthAnchor.constraint(equalToConstant: 50),
            profileBorderView.heightAnchor.constraint(equalToConstant: 50),
            
            addProfileImageButton.trailingAnchor.constraint(equalTo: profileBorderView.trailingAnchor, constant: 4),
            addProfileImageButton.bottomAnchor.constraint(equalTo: profileBorderView.bottomAnchor, constant: 4),
            addProfileImageButton.widthAnchor.constraint(equalToConstant: 20),
            addProfileImageButton.heightAnchor.constraint(equalToConstant: 20),
            
            cardProfilePicture.centerXAnchor.constraint(equalTo: profileBorderView.centerXAnchor),
            cardProfilePicture.centerYAnchor.constraint(equalTo: profileBorderView.centerYAnchor),
            cardProfilePicture.widthAnchor.constraint(equalToConstant: 40),
            cardProfilePicture.heightAnchor.constraint(equalToConstant: 40),
            
            cardCategoryTitleLabel.topAnchor.constraint(equalTo: profileBorderView.bottomAnchor, constant: 10),
            cardCategoryTitleLabel.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            
            cardCategoryDateLabel.topAnchor.constraint(equalTo: cardCategoryTitleLabel.bottomAnchor, constant: 2),
            cardCategoryDateLabel.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            
            cardTitleLabel.topAnchor.constraint(equalTo: cardCategoryDateLabel.bottomAnchor, constant: 20),
            cardTitleLabel.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 20),
            cardTitleLabel.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),
            
            likeAndTimeLabel.topAnchor.constraint(equalTo: cardTitleLabel.bottomAnchor, constant: 10),
            likeAndTimeLabel.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: likeAndTimeLabel.bottomAnchor, constant: 30),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 40),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -40),
            
            actionsView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -20),
            actionsView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 20),
            actionsView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),
            actionsView.heightAnchor.constraint(equalToConstant: 80)
        ])
            
    }
    
    private func updateLayout(for mode: ViewMode) {
        if mode == .full {
            containerLeadingConstraints?.constant = 0
            containerTopConstraints?.constant = 0
            containerBottomConstraints?.constant = 0
            containerTraillingingConstraints?.constant = 0
            descriptionTitleLabel.isHidden = false
        }else {
            containerLeadingConstraints?.constant = 30
            containerTopConstraints?.constant = 15
            containerBottomConstraints?.constant = -15
            containerTraillingingConstraints?.constant = -30
            descriptionTitleLabel.isHidden = true
        }
        actionsView.updateLayout(for: mode)
    }
    
    public func setUpView(data: CardViewModel) {
        cardCategoryTitleLabel.text = data.categoryName
        cardCategoryDateLabel.text = data.categoryDate
        cardTitleLabel.text = data.cardTitle
        likeAndTimeLabel.attributedText = NSAttributedString.featureText(data.likeCount ?? "", data.duration ?? "")
        descriptionTitleLabel.text = data.cardDescription
        cardImage.image = UIImage(named: data.cardImage ?? "")
        cardProfilePicture.image = UIImage(named: data.categoryImage ?? "")
    }
    
    
    
    

}
