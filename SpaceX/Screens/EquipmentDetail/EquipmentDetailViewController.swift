//
//  EquipmentDetailViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import UIKit


class EquipmentDetailViewController: UIViewController {
    
    var presenter: EquipmentDetailPresenterProtocol?
    

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let horizontalContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    let rectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        return view
    }()
    
    var heightAnchor: NSLayoutConstraint?
    var contentHeightAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        horizontalScrollView.delegate = self
        
        view.addSubview(mainStackView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
        
        let centerYAnchor = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerYAnchor.priority = .init(rawValue: 100)
        centerYAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        mainStackView.addArrangedSubview(horizontalScrollView)

        heightAnchor = horizontalScrollView.heightAnchor.constraint(equalToConstant: 200)
        heightAnchor?.isActive = true
        
        horizontalScrollView.addSubview(horizontalContentView)
        
        NSLayoutConstraint.activate([
            horizontalContentView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            horizontalContentView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
            horizontalContentView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            horizontalContentView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            horizontalContentView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            horizontalContentView.widthAnchor.constraint(greaterThanOrEqualTo: horizontalScrollView.widthAnchor)
        ])
        
        let centerXAnchor = horizontalContentView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor)
        centerXAnchor.priority = .init(rawValue: 100)
        centerXAnchor.isActive = true
        
        for i in 0...10 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tag = i
            view.backgroundColor = .systemBlue
            
            let offset = CGFloat(20 + (i * 310))
            
            horizontalContentView.addSubview(view)
            
            switch i {
            case 0:
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: horizontalContentView.topAnchor, constant: 10),
                    view.leadingAnchor.constraint(equalTo: horizontalContentView.leadingAnchor, constant: offset),
                    view.heightAnchor.constraint(equalToConstant: 180),
                    view.widthAnchor.constraint(equalToConstant: 300)
                ])
                
            case 1:
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: horizontalContentView.topAnchor, constant: 10),
                    view.leadingAnchor.constraint(equalTo: horizontalContentView.leadingAnchor, constant: offset),
                    view.widthAnchor.constraint(equalToConstant: 300)
                ])
                
                contentHeightAnchor = view.heightAnchor.constraint(equalToConstant: 180)
                contentHeightAnchor?.isActive = true
                
            default:
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: horizontalContentView.topAnchor, constant: 10),
                    view.leadingAnchor.constraint(equalTo: horizontalContentView.leadingAnchor, constant: offset),
                    view.heightAnchor.constraint(equalToConstant: 280),
                    view.widthAnchor.constraint(equalToConstant: 300)
                ])
            }
            
//            if i != 1 {
//                NSLayoutConstraint.activate([
//                    view.topAnchor.constraint(equalTo: horizontalContentView.topAnchor, constant: 10),
//                    view.leadingAnchor.constraint(equalTo: horizontalContentView.leadingAnchor, constant: offset),
//                    view.heightAnchor.constraint(equalToConstant: 180),
//                    view.widthAnchor.constraint(equalToConstant: 300)
//                ])
//            } else {
//                NSLayoutConstraint.activate([
//                    view.topAnchor.constraint(equalTo: horizontalContentView.topAnchor, constant: 10),
//                    view.leadingAnchor.constraint(equalTo: horizontalContentView.leadingAnchor, constant: offset),
//                    view.widthAnchor.constraint(equalToConstant: 300)
//                ])
//
//                contentHeightAnchor = view.heightAnchor.constraint(equalToConstant: 180)
//                contentHeightAnchor?.isActive = true
//            }
            
            if i == 10 {
                view.trailingAnchor.constraint(equalTo: horizontalContentView.trailingAnchor, constant: -20).isActive = true
            }
        }
        
        for _ in 0...10 {
            let view = UIView()
            view.backgroundColor = .systemRed

            mainStackView.addArrangedSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
    
}



extension EquipmentDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        switch scrollView.contentOffset.x {
        case ..<0:
            heightAnchor?.constant = 200
            contentHeightAnchor?.constant = 180
            
        case 0..<200:
            heightAnchor?.constant = 200 + scrollView.contentOffset.x * 0.5
            contentHeightAnchor?.constant = 180 + scrollView.contentOffset.x * 0.5
            
        case 200...:
            heightAnchor?.constant = 300
            contentHeightAnchor?.constant = 280
            
        default:
            break
        }

    }
}
