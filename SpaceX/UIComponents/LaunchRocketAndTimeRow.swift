//
//  LaunchRocketAndTimeRow.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.11.2021.
//

import UIKit
import SpaceSDK


class LaunchRocketAndTimeRow: UIView {
    
    //MARK: - UI Component
    let rocketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.white, for: .normal)
        button.layer.cornerRadius = 12
        if #available(iOS 13.0, *) {
            button.layer.cornerCurve = .continuous
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = Colors.mainAccent
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        return button
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = Colors.secondaryLabel
        return label
    }()
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = Colors.secondaryLabel
        return label
    }()
    
    let activeStateView: ActiveStateView = {
        let activeStateView = ActiveStateView()
        activeStateView.translatesAutoresizingMaskIntoConstraints = false
        activeStateView.changeTitles(negativeTitle: "Failure", positiveTitle: "Success")
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
        addSubview(rocketButton)
        addSubview(timerLabel)
        addSubview(dateLabel)
        addSubview(hoursLabel)
        addSubview(activeStateView)
        
        NSLayoutConstraint.activate([
            rocketButton.topAnchor.constraint(equalTo: topAnchor),
            rocketButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: topAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            activeStateView.topAnchor.constraint(equalTo: topAnchor),
            activeStateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2),
            hoursLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hoursLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func prepareForLaunch(_ launch: Launch, rocketName: String, state: LaunchState) {
        rocketButton.setTitle(rocketName, for: .normal)
        
        let regularDateFont = UIFont.systemFont(ofSize: 11, weight: .regular)
        let semiboldDateFont = UIFont.systemFont(ofSize: 11, weight: .semibold)
        
        let isFutureLaunch = state == .unknown
        
        dateLabel.font = isFutureLaunch ? regularDateFont : semiboldDateFont
        hoursLabel.font = isFutureLaunch ? semiboldDateFont : regularDateFont
        
        timerLabel.isHidden = !isFutureLaunch
        activeStateView.isHidden = isFutureLaunch
        
        activeStateView.isActive = launch.success ?? false
        
        dateLabel.text = DateFormatters.monthDayAndYear.getDescription(launch.date)
        hoursLabel.text = DateFormatters.hourseAndMinutes.getDescription(launch.date)
        
    }
    
}
