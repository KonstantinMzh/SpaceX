//
//  EquipmentDetailViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import UIKit
import SpaceSDK
import Gallery

class EquipmentDetailViewController: UIViewController {
    
    var presenter: EquipmentDetailPresenterProtocol?
    weak var picker: PickerViewController?

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
        stackView.spacing = 25
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: - Rows
    let headerRow = EquipmentHeaderRow()
    let descriptionRow = DescriptionRow()
    let gallery = Gallery()
    let stageGallery = StageGallery()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchRockets()
    }
    
    
    //MARK: - Configuration
    func configure() {
        view.backgroundColor = Colors.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
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
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gallery.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let centerYAnchor = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerYAnchor.priority = .init(rawValue: 100)
        centerYAnchor.isActive = true
        
        configureStackView()
        
        for _ in 0...10 {
            let view = UIView()
            view.backgroundColor = Colors.gray6

            stackView.addArrangedSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
    }
    
    func configureStackView() {
        stackView.addArrangedSubview(headerRow)
        stackView.addArrangedSubview(descriptionRow)
        stackView.addArrangedSubview(stageGallery)
        stackView.addArrangedSubview(gallery)
    }
    
    func updatePicker(_ options: [String]) {
        picker?.setCollection(options)
    }
    
    func updateUIForEntity(_ entity: Rocket) {
        headerRow.nameLabel.text = entity.name
        headerRow.activeState.isActive = entity.active
        descriptionRow.descriptionLabel.text = entity.rocketDescription
        gallery.images = entity.images
        stageGallery.stages = entity.getStages()
    }
    
}
