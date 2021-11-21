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
    
    let substrateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray6
        if #available(iOS 13.0, *) {
            view.layer.cornerCurve = .continuous
        }
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()
    
    let launchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = Colors.label
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 11, weight: .regular)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        label.textColor = Colors.label
        label.textAlignment = .right
        return label
    }()
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 11, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh + 2, for: .vertical)
        label.textColor = Colors.label
        label.textAlignment = .right
        return label
    }()
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 11, weight: .regular)
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
        label.textColor = Colors.secondaryLabel
        return label
    }()
    
    let activeView: ActiveStateView = {
        let activeView = ActiveStateView()
        activeView.translatesAutoresizingMaskIntoConstraints = false
        activeView.changeTitles(negativeTitle: "Failure", positiveTitle: "Success")
        return activeView
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

        contentView.addSubview(substrateView)
        substrateView.addSubview(launchNameLabel)
        substrateView.addSubview(dateLabel)
        substrateView.addSubview(hoursLabel)
        substrateView.addSubview(rocketNameLabel)
        substrateView.addSubview(activeView)
        
        NSLayoutConstraint.activate([
            substrateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            substrateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            substrateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            substrateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            launchNameLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 15),
            launchNameLabel.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 15),
            launchNameLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 13),
            dateLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            hoursLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            activeView.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: 7),
            activeView.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            rocketNameLabel.topAnchor.constraint(equalTo: launchNameLabel.bottomAnchor, constant: 7),
            rocketNameLabel.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 15)
        ])
        
        let bottomConstraint = activeView.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor,
                                                                  constant: -15)
        bottomConstraint.isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        launchNameLabel.text = ""
    }
    
    func prepareForLaunch(_ launch: Launch)  {
        launchNameLabel.text = launch.name
        dateLabel.text = DateFormatters.monthDayAndYear.getDescription(launch.date)
        hoursLabel.text = DateFormatters.hourseAndMinutes.getDescription(launch.date)
        activeView.isActive = launch.success ?? false
    }
    
    func setRocketName(_ rocketName: String) {
        rocketNameLabel.text = rocketName
    }
    
}
