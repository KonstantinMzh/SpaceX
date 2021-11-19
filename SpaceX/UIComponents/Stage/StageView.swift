//
//  StageView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 18.11.2021.
//

import UIKit
import SpaceSDK

class StageView: UIView {
    
    var offset: CGFloat = 0 {
        didSet {
            offsetChanged(offset)
        }
    }
    
    var thrusts: [Thrust] = []
    var rows: [StageRowWithOneValue] = []
    var thrustsRow = StageRowWithTwoValues(key: "Thrust",
                                           firstMeasurementUnit: .kN,
                                           secondMeasurementUnit: .lbf)
    
    var selectedThrust: Int = 0 {
        didSet {
            selectThrustWithIndex(selectedThrust)
        }
    }
    
    //MARK: - UI components
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 13
        return stackView
    }()
    
    let thrustSelector: StageSelector = {
        let selector = StageSelector(options: ["Vacuum", "Sea Level"])
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        
        backgroundColor = Colors.gray6
        layer.cornerRadius = 14
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        clipsToBounds = true
        
        addSubview(stackView)
        addSubview(thrustSelector)
        
        thrustSelector.delegate = self
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            thrustSelector.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 7),
            thrustSelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
        
        let stageProperties: [StageProperty] = [.fuelAmount, .burnTime, .enginesNumber, .reusable]
        
        for property in stageProperties {
            let stageRow = StageRowWithOneValue(key: property.rawValue,
                                                measurementUnit: property.getMeasurementUnit())
            stackView.addArrangedSubview(stageRow)
            rows.append(stageRow)
        }
                
        stackView.addArrangedSubview(thrustsRow)
        

    }
    
    
    func prepareForStage(_ stage: Stage) {
        thrusts = stage.getThrusts()
        thrustSelector.isHidden = thrusts.count < 2
        
        rows[safe: 0]?.setValue("\(stage.fuelAmountTons ?? 0)")
        rows[safe: 1]?.setValue("\(stage.burnTimeSec ?? 0)")
        rows[safe: 2]?.setValue("\(stage.engines ?? 0)")
        rows[safe: 3]?.setValue(stage.reusable ?? false)
        
        selectThrustWithIndex(selectedThrust)
        
    }
    
    private func selectThrustWithIndex(_ index: Int) {
        guard let thrust = thrusts[safe: index] else { return }
        thrustsRow.setValues(first: "\(thrust.kN)", second: "\(thrust.lbf)")
    }
    
    
    //MARK: - Offset Handler
    private func offsetChanged(_ newOffset: CGFloat) {
        
    }
    
}



extension StageView: StageSelectorDelegate {
    
    func optionDidSelected(_ option: Int) {
        selectedThrust = option
    }
    
}
