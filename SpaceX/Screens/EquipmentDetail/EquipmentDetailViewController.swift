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
        configureNavigationBar(title: "", preferredLargeTitle: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        picker?.title = presenter?.getTitle()
        presenter?.fetch()
        configureStackView()
    }
    
    
    //MARK: - Configuration
    private func configure() {
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
        
        
    }

    
    func updatePicker(_ options: [String]) {
        picker?.setCollection(options)
    }
    
    func updateUIForRocket(_ rocket: Rocket) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        headerRow.nameLabel.text = rocket.name
        headerRow.activeState.isActive = rocket.active
        descriptionRow.setText(rocket.rocketDescription)
        gallery.images = rocket.images
        stageGallery.stages = rocket.getStages()
        
    }

    func updateUIForDragon(_ dragon: Dragon) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)

        headerRow.nameLabel.text = dragon.name
        headerRow.activeState.isActive = dragon.active
        descriptionRow.setText(dragon.dragonDescription)
        gallery.images = dragon.images
        
    }
    
    private func configureStackView() {
        removeRowsFromStackView()
        
        guard let equipmentType = presenter?.getType() else { return }
        
        switch equipmentType {
        case .rocket:
            stackView.addArrangedSubview(headerRow)
            stackView.addArrangedSubview(descriptionRow)
            stackView.addArrangedSubview(stageGallery)
            stackView.addArrangedSubview(gallery)
            
        case .capsule:
            stackView.addArrangedSubview(headerRow)
            stackView.addArrangedSubview(descriptionRow)
            stackView.addArrangedSubview(gallery)
        }
        
        stackView.addArrangedSubview(UIView())

        
    }
    
    private func removeRowsFromStackView() {
        for view in stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(rocket: Rocket) {
        super.init(nibName: nil, bundle: nil)
        updateUIForRocket(rocket)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
