//
//  BannerView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 28.11.2021.
//

import UIKit


class BannerView: UIView {
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textColor = Colors.white
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func configure() {
        backgroundColor = Colors.red
        let distanceFromTop = UIApplication.shared.windows[0].safeAreaLayoutGuide.layoutFrame.minY

        addSubview(messageLabel)
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.5),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10 + distanceFromTop),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: messageLabel.leadingAnchor)
        ])
        
    }

}
