//
//  StageGallery.swift
//  SpaceX
//
//  Created by Константин Маламуж on 19.11.2021.
//

import UIKit
import SpaceSDK


class StageGallery: UIView {
    
    
    var stages: [Stage] = [] {
        didSet {
            prepareForStages(stages)
        }
    }
    
    
    //MARK: - UI Components
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.axis = .horizontal
        stackView.alignment = .top
        return stackView
    }()
    
    var scrollViewHeightAnchor: NSLayoutConstraint?

    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Configuration
    private func configure() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        scrollViewHeightAnchor = scrollView.heightAnchor.constraint(equalToConstant: 260)
        scrollViewHeightAnchor?.priority = .init(rawValue: 500)
        scrollViewHeightAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor)
        ])
        
        let centerXAnchor = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerXAnchor.priority = .init(rawValue: 100)
        centerXAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    
    private func prepareForStages(_ stages: [Stage]) {
        for view in stackView.subviews {
            view.removeFromSuperview()
        }
        
        for stage in stages {
            let stageView = StageView()
            stageView.prepareForStage(stage)
            stackView.addArrangedSubview(stageView)
        }
    }
    
    
}



extension StageGallery: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        switch scrollView.contentOffset.x {
        case ..<0:
            scrollViewHeightAnchor?.constant = 260
            
        case 0..<200:
            scrollViewHeightAnchor?.constant = 260 - scrollView.contentOffset.x * 0.2

        case 200...:
            scrollViewHeightAnchor?.constant = 220
            
        default:
            break
        }

    }
    
}
