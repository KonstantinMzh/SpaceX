//
//  EquipmentHeaderRow.swift
//  SpaceX
//
//  Created by Константин Маламуж on 19.11.2021.
//

import UIKit


class EquipmentHeaderRow: UIView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let activeState: ActiveStateView = {
        let activeStateView = ActiveStateView()
        activeStateView.translatesAutoresizingMaskIntoConstraints = false
        return activeStateView
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Configure
    func configure() {
        addSubview(nameLabel)
        addSubview(activeState)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            activeState.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            activeState.bottomAnchor.constraint(equalTo: bottomAnchor),
            activeState.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
}
