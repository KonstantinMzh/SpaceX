//
//  StageRowView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 18.11.2021.
//

import UIKit


class StageRowWithOneValue: UIView {
    
    let measurementUnit: MeasurementUnit?
    let key: String
    
    //MARK: - UI components
    lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = key
        label.textColor = Colors.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var valueView: ValueView = {
        let valueView = ValueView(measurementUnit: measurementUnit)
        valueView.translatesAutoresizingMaskIntoConstraints = false
        return valueView
    }()
    
    
    //MARK: - Init
    init(key: String, measurementUnit: MeasurementUnit? = nil) {
        self.measurementUnit = measurementUnit
        self.key = key
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Configure
    func configure() {
        addSubview(keyLabel)
        addSubview(valueView)
        
        NSLayoutConstraint.activate([
            keyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valueView.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    
    func setValue(_ value: String) {
        valueView.setValue(value)
    }
    
    func setValue(_ value: Bool) {
        valueView.setValue(value)
    }
}
