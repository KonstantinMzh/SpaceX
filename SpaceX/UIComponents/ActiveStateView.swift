//
//  ActiveStateView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 19.11.2021.
//

import UIKit


class ActiveStateView: UIView {
    
    var isActive: Bool = true {
        didSet {
            stateChanged(isActive)
        }
    }
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    
    var negativeTitle = "Inactive"
    var positiveTitle = "Active"
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        addSubview(stateLabel)
        
        NSLayoutConstraint.activate([
            stateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            stateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11)
        ])
        
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1.5
        
        isActive = true
    }

    
    private func stateChanged(_ newState: Bool) {
        stateLabel.textColor = newState ? Colors.green : Colors.red
        stateLabel.text = newState ? positiveTitle : negativeTitle
        layer.borderColor = newState ? Colors.green.cgColor : Colors.red.cgColor
    }
    
    func changeTitles(negativeTitle: String, positiveTitle: String) {
        self.negativeTitle = negativeTitle
        self.positiveTitle = positiveTitle
    }
    
}
