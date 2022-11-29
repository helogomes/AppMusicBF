//
//  CardViewTableViewCell.swift
//  AppMusicBF
//
//  Created by user218997 on 17/11/22.
//

import UIKit

class CardViewTableViewCell: UITableViewCell {
    
    static let identifier: String = "CardViewTableViewCell"
    
    lazy var cardView: CustomCardView = {
        let view = CustomCardView(mode: .card)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setUpContraints()
        
        selectionStyle = .none
    }
    
    public func setUpCell(data: CardViewModel) {
        cardView.setUpView(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addSubViews() {
        contentView.addSubview(cardView)
    }
    
    fileprivate func setUpContraints() {
        cardView.pin(to: self)
    }
   

}
