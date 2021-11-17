//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Константин Маламуж on 12.11.2021.
//

import UIKit
import SpaceSDK


class FutureLaunchCell: UITableViewCell {
    
    static let id = "futureLaunchCell"
    weak var delegate: LaunchDelegate?
    
    var launchDate: TimeInterval?
    
    let launchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
        contentView.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            launchNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            launchNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: launchNameLabel.bottomAnchor, constant: 10),
            timerLabel.leadingAnchor.constraint(equalTo: launchNameLabel.leadingAnchor)
        ])
        
        let bottomConstraint = timerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        launchNameLabel.text = ""
        timerLabel.text = ""
    }
    
    func prepareForLaunch(_ launch: Launch) {
        print(Date(timeIntervalSince1970: launch.date))
        launchNameLabel.text = launch.name
        launchDate = launch.date
        updateTimer()
    }
    
    func updateTimer() {
        guard let launchDate = launchDate else { return }

        let diffTimeInterval = launchDate - Date().timeIntervalSince1970
         
//        print(diffTimeInterval)
        if diffTimeInterval <= 0 {
            delegate?.launchHappened()
            return
        }
        
        let dateDescription = DateFormatters.dayBeforeLaunch.getDescription(diffTimeInterval)
        timerLabel.text = dateDescription
    }
    
}
