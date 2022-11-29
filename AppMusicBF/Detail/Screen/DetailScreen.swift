//
//  DetailScreen.swift
//  AppMusicBF
//
//  Created by user218997 on 22/11/22.
//

import UIKit

protocol DetailScreenDelegate: AnyObject {
    func tappedBackButtonAction()
}

class DetailScreen: UIView {
    
    var cardModel: CardViewModel?
    var navBarTopAnchor: NSLayoutConstraint?
    var playerViewBottomAnchor: NSLayoutConstraint?
    
    private weak var delegate: DetailScreenDelegate?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = .flexibleHeight
        view.bounces = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var cardView: CustomCardView = {
        let view = CustomCardView(mode: .full)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cardContainerView.layer.cornerRadius = 0.0
        view.setUpView(data: cardModel ?? CardViewModel())
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15
        button.setBackgroundImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var navBar: CustomNavBar = {
        let nav = CustomNavBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .black
        nav.setUpView(data: cardModel ?? CardViewModel())
        return nav
    }()
    
    lazy var playerView: CustomPlayerView = {
        let pv = CustomPlayerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    @objc func tappedBackButton() {
        delegate?.tappedBackButtonAction()
    }
    
    init(dataView: CardViewModel?) {
        super.init(frame: CGRect())
        cardModel = dataView
        DispatchQueue.main.async {
            self.addSubViews()
            self.setUpConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(cardView)
        scrollView.addSubview(tableView)
        addSubview(navBar)
        addSubview(backButton)
        addSubview(playerView)
    }
    
    private func setUpConstraints() {
        let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        let topPadding = window?.safeAreaInsets.top
        print(topPadding as Any)
        
        scrollView.pin(to: self)
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -(topPadding ?? 0)),
            cardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 500),
            cardView.widthAnchor.constraint(equalToConstant: frame.size.width),
            
            tableView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat((80 * (cardModel?.cardList?.count ?? 0)) + 20)),
            tableView.widthAnchor.constraint(equalToConstant: frame.size.width),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: ((topPadding ?? 0.0) + 80)),
            
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 120)
            
        ])
        
        navBarTopAnchor = navBar.topAnchor.constraint(equalTo: topAnchor, constant: -((topPadding ?? 0.0) + 60))
        navBarTopAnchor?.isActive = true
        
        playerViewBottomAnchor = playerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 120)
        playerViewBottomAnchor?.isActive = true
    }
    
    public func configAllDelegates(tableViewDeletage: UITableViewDelegate, tableViewDataSource: UITableViewDataSource, scrollViewDelegate: UIScrollViewDelegate, detailScreemDelegate: DetailScreenDelegate) {
        tableView.delegate = tableViewDeletage
        tableView.dataSource = tableViewDataSource
        scrollView.delegate = scrollViewDelegate
        delegate = detailScreemDelegate
    }
}
