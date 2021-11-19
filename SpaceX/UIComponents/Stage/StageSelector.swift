//
//  StageSelector.swift
//  SpaceX
//
//  Created by Константин Маламуж on 19.11.2021.
//

import UIKit


protocol StageSelectorDelegate: AnyObject {
    func optionDidChoosed(_ option: Int)
}

class StageSelector: UIView {
    
    weak var delegate: StageSelectorDelegate?
    
    var options: [String]
    var choosedOption: Int {
        didSet {
            delegate?.optionDidChoosed(choosedOption)
            unselectButtonWithIndex(oldValue)
            selectButtonWithIndex(choosedOption)
        }
    }
    
    //MARK: - UI Components
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    var buttons: [UIButton] = []
    
    
    //MARK: - Init
    init(options: [String]) {
        self.options = options
        self.choosedOption = 0
        super.init(frame: .zero)
        
        createButtons()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func createButtons() {
        for (i, option) in options.enumerated() {
            let button = UIButton()
            button.backgroundColor = Colors.white
            button.setTitle(option, for: .normal)
            button.setTitleColor(Colors.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            button.layer.cornerRadius = 10
            if #available(iOS 13.0, *) {
                button.layer.cornerCurve = .continuous
            }
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
            buttons.append(button)
            button.tag = i
        }
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        choosedOption = button.tag
    }
    
    private func configure() {
        choosedOption = 0
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func selectButtonWithIndex(_ index: Int) {
        guard let button = buttons[safe: index] else { return }
        button.backgroundColor = Colors.black
        button.setTitleColor(Colors.white, for: .normal)
    }
    
    private func unselectButtonWithIndex(_ index: Int) {
        guard let button = buttons[safe: index] else { return }
        button.backgroundColor = Colors.white
        button.setTitleColor(Colors.black, for: .normal)
    }
    
}
