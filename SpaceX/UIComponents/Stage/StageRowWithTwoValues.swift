//
//  ThrustView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 18.11.2021.
//

import UIKit


class StageRowWithTwoValues: StageRowWithOneValue {
    
    let secondMeasurementUnit: MeasurementUnit?
    
    lazy var secondValueView: ValueView = {
        let valueView = ValueView(measurementUnit: secondMeasurementUnit)
        valueView.translatesAutoresizingMaskIntoConstraints = false
        return valueView
    }()
    
    //MARK: - Init
    init(key: String, firstMeasurementUnit: MeasurementUnit?, secondMeasurementUnit: MeasurementUnit?) {
        self.secondMeasurementUnit = secondMeasurementUnit
        super.init(key: key, measurementUnit: secondMeasurementUnit)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        addSubview(secondValueView)
        
        NSLayoutConstraint.activate([
            secondValueView.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondValueView.trailingAnchor.constraint(equalTo: valueView.leadingAnchor, constant: 25)
        ])
    }
    
    func setValues(first: String, second: String) {
        setValue(first)
        secondValueView.setValue(second)
    }
    
}
