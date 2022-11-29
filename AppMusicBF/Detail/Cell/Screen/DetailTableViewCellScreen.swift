//
//  DetailTableViewCellScreen.swift
//  AppMusicBF
//
//  Created by user218997 on 24/11/22.
//

import UIKit

class DetailTableViewCellScreen: UIView {
    
    lazy var thumbImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "demo")
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "teste nome"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "teste subtitulo"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "love")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        return button
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
        addSubview(thumbImage)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(likeButton)
        addSubview(moreButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            thumbImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            thumbImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImage.heightAnchor.constraint(equalToConstant: 60),
            thumbImage.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: thumbImage.trailingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            moreButton.widthAnchor.constraint(equalToConstant: 35),
            moreButton.heightAnchor.constraint(equalToConstant: 35),
            moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            likeButton.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -15),
            likeButton.widthAnchor.constraint(equalToConstant: 35),
            likeButton.heightAnchor.constraint(equalToConstant: 35),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    public func setUpCell(data: CardListModel) {
        titleLabel.text = data.listTitle
        subtitleLabel.text = data.listSubtitle
        thumbImage.image = UIImage(named: data.listImage ?? "")
    }
    
}
