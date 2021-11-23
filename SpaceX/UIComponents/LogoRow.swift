//
//  LogoRow.swift
//  SpaceX
//
//  Created by Константин Маламуж on 23.11.2021.
//

import UIKit


class LogoRow: UIView {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 216),
            logoImageView.heightAnchor.constraint(equalToConstant: 27),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
