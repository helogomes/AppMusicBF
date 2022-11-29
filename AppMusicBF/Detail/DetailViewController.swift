//
//  DetailViewController.swift
//  AppMusicBF
//
//  Created by user218997 on 22/11/22.
//

import UIKit

enum StateAnimation {
    case long
    case short
}

class DetailViewController: UIViewController {
    
    var screen: DetailScreen?
    var cardModel: CardViewModel?
    var valueAnimation: StateAnimation = .long
    
    override func loadView() {
        screen = DetailScreen(dataView: self.cardModel)
        screen?.configAllDelegates(tableViewDeletage: self, tableViewDataSource: self, scrollViewDelegate: self, detailScreemDelegate: self)
        view = screen
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func animationWithView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        
        let topPadding = window?.safeAreaInsets.top
        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y >= 300 {
            screen?.navBarTopAnchor?.constant = 0
            
            if valueAnimation == .long {
                animationWithView()
            }
            valueAnimation = .short
        }else {
            screen?.navBarTopAnchor?.constant = -((topPadding ?? 0.0) + 80)
            
            if valueAnimation == .short {
                animationWithView()
            }
            valueAnimation = .long
        }
    }
}

extension DetailViewController: DetailScreenDelegate {
    func tappedBackButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardModel?.cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell
        cell?.setUpCell(data: cardModel?.cardList?[indexPath.row] ?? CardListModel())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        screen?.playerView.setUpView(data: cardModel?.cardList?[indexPath.row] ?? CardListModel())
        screen?.playerViewBottomAnchor?.constant = 0
        animationWithView()
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
}
