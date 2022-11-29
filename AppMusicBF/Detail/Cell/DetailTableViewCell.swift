//
//  DetailTableViewCell.swift
//  AppMusicBF
//
//  Created by user218997 on 24/11/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static public let identifier: String = "DetailTableViewCell"
    
    var screen: DetailTableViewCellScreen = DetailTableViewCellScreen()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        contentView.addSubview(screen)
    }
    
    private func setUpConstraints() {
        screen.pin(to: contentView)
    }
    
    public func setUpCell(data: CardListModel) {
        screen.setUpCell(data: data)
    }
    
}
