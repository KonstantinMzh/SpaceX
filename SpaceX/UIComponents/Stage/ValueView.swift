//
//  ValueView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 18.11.2021.
//

import UIKit


class ValueView: UIView {
    
    var measurementUnit: MeasurementUnit?
    
    //MARK: - UI components
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Colors.label
        return label
    }()
    
    private let measurementUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    //MARK: - Init
    init(measurementUnit: MeasurementUnit? = nil) {
        super.init(frame: .zero)
        configure()
        setMeasurementUnit(measurementUnit)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Configuration
    private func configure() {
        addSubview(valueLabel)
        addSubview(measurementUnitLabel)
        
        NSLayoutConstraint.activate([
            measurementUnitLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            measurementUnitLabel.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: -1.10),
            measurementUnitLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 80),
            valueLabel.trailingAnchor.constraint(equalTo: measurementUnitLabel.leadingAnchor, constant: -4)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 114, height: 24)
    }
    
    func setMeasurementUnit(_ measurementUnit: MeasurementUnit?) {
        measurementUnitLabel.text = measurementUnit?.rawValue
    }
    
    func setValue(_ value: String) {
        valueLabel.textColor = Colors.label
        valueLabel.text = value
    }
    
    func setValue(_ value: Bool) {
        valueLabel.textColor = value ? Colors.green : Colors.red
        valueLabel.text = value ? "Yes" : "No"
    }
    
}
