//
//  OldLaunchCell.swift
//  SpaceX
//
//  Created by Константин Маламуж on 12.11.2021.
//

import UIKit
import SpaceSDK


class OldLaunchCell: UITableViewCell {
    
    static let id = "oldLaunchCell"
    
    let launchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setCell() {
        selectionStyle = .none

        contentView.addSubview(launchNameLabel)
        
        NSLayoutConstraint.activate([
            launchNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            launchNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        let bottomConstraint = launchNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.priority = .init(rawValue: 900)
        bottomConstraint.isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        launchNameLabel.text = ""
    }
    
    func prepareForLaunch(_ launch: Launch)  {
        launchNameLabel.text = launch.name
    }
    
}
