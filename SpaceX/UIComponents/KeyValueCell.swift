//
//  KeyValueCell.swift
//  SpaceX
//
//  Created by Константин Маламуж on 23.11.2021.
//

import UIKit


class KeyValueCell: UIView {
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let keyLabel: UILabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.label
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        addSubview(stackView)
        stackView.addArrangedSubview(keyLabel)
        stackView.addArrangedSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        
        NSLayoutConstraint.activate([
            keyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
        
    }
    
    func setKeyAndValue(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
    
    
}

