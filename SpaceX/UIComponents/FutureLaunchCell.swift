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
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = Colors.label
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 19, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = Colors.label
        label.textAlignment = .right
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 11, weight: .regular)
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        label.textColor = Colors.secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 11, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh + 2, for: .vertical)
        label.textColor = Colors.secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 11, weight: .regular)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = Colors.secondaryLabel
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
        
        contentView.addSubview(substrateView)
        substrateView.addSubview(launchNameLabel)
        substrateView.addSubview(timerLabel)
        substrateView.addSubview(dateLabel)
        substrateView.addSubview(hoursLabel)
        substrateView.addSubview(rocketNameLabel)
        
        NSLayoutConstraint.activate([
            substrateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            substrateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            substrateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            substrateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            launchNameLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 15),
            launchNameLabel.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 15),
            timerLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 7),
            dateLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            hoursLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            rocketNameLabel.topAnchor.constraint(equalTo: launchNameLabel.bottomAnchor, constant: 7),
            rocketNameLabel.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 15)
        ])
        
        let bottomConstraint = hoursLabel.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -15)
        bottomConstraint.isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        launchNameLabel.text = ""
        timerLabel.text = ""
    }
    
    func prepareForLaunch(_ launch: Launch) {
        launchNameLabel.text = launch.name
        launchDate = launch.date
        
        if let launchDate = launchDate {
            dateLabel.text = DateFormatters.monthDayAndYear.getDescription(launchDate)
            hoursLabel.text = DateFormatters.hourseAndMinutes.getDescription(launchDate)
        }
        
        updateTimer()
    }
    
    func setRocketName(_ rocketName: String) {
        rocketNameLabel.text = rocketName
    }
    
    func updateTimer() {
        guard let launchDate = launchDate else { return }

        let diffTimeInterval = launchDate - Date().timeIntervalSince1970
         
        if diffTimeInterval <= 0 {
            delegate?.launchHappened()
            return
        }

        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: Date(timeIntervalSince1970: diffTimeInterval))
        
        if let day = dateComponent.day, day <= 2 {
            timerLabel.text =  DateFormatters.dayBeforeLaunch.getDescription(diffTimeInterval)
        }
        
        if let day = dateComponent.day, day == 2 {
            timerLabel.text = "\(day) day"
        }

        if let days = dateComponent.day, days >= 2 {
            timerLabel.text = "\(days) days"
        }

        if let month = dateComponent.month, month == 2 {
            timerLabel.text = "\(month) month"
        }

        if let months = dateComponent.month, months >= 2 {
            timerLabel.text = "\(months) months"
        }
        
        if let year = dateComponent.year, year == 2 {
            timerLabel.text = "\(year) year"
        }
        
        if let years = dateComponent.year, years == 2 {
            timerLabel.text = "\(years) years"
        }
    }
    
}
