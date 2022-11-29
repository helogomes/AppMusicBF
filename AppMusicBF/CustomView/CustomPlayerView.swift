//
//  CustomPlayerView.swift
//  AppMusicBF
//
//  Created by user218997 on 29/11/22.
//

import UIKit
import MarqueeLabel

class CustomPlayerView: UIView {
    
    var videoTimer: Timer?
    var time: CGFloat = 0.0
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var marqueeLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.textColor = .white.withAlphaComponent(0.8)
        label.type = .continuous
        label.animationCurve = .linear
        label.fadeLength = 10.0
        label.leadingBuffer = 30.0
        label.trailingBuffer = 30.0
        return label
    }()
    
    lazy var pausePlayButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white.withAlphaComponent(0.8)
        return image
    }()
    
    lazy var trackBar: UIProgressView = {
        let v = UIProgressView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.progressTintColor = .yellow.withAlphaComponent(0.8)
        v.progress = 0.0
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(imageView)
        addSubview(marqueeLabel)
        addSubview(pausePlayButton)
        addSubview(trackBar)
        
        videoTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(changeTrackBar), userInfo: nil, repeats: true)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            
            marqueeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            marqueeLabel.trailingAnchor.constraint(equalTo: pausePlayButton.leadingAnchor, constant: -5),
            marqueeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            
            pausePlayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pausePlayButton.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            pausePlayButton.heightAnchor.constraint(equalToConstant: 40),
            pausePlayButton.widthAnchor.constraint(equalToConstant: 40),
            
            trackBar.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            trackBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackBar.topAnchor.constraint(equalTo: topAnchor)
        
        ])
    }
    
    @objc func changeTrackBar() {
        time += 0.001
        trackBar.progress = Float(time / 120)
        if time >= 120 {
            videoTimer?.invalidate()
            videoTimer = nil
        }
    }
    
    public func setUpView(data: CardListModel) {
        imageView.image = UIImage(named: data.listImage ?? "")
        marqueeLabel.text = data.listTitle
        time = 0.0
        trackBar.progress = 0.0
        videoTimer = nil
        videoTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(changeTrackBar), userInfo: nil, repeats: true)
    }
}
