//
//  RocketInfoViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import UIKit
import SpaceSDK
import Gallery

class RocketInfoViewController: UIViewController {
    
    var presenter: RocketInfoPresenterProtocol?
    weak var picker: PickerViewController?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let rocketDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let firstFlightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let gallery = Gallery()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchRockets()
    }
    
    
    func configure() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(rocketNameLabel)
        stackView.addArrangedSubview(rocketDescriptionLabel)
        stackView.addArrangedSubview(firstFlightLabel)
        stackView.addArrangedSubview(gallery)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])

        gallery.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(gallery)
        NSLayoutConstraint.activate([
            gallery.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        gallery.images = []
        
    }
    
    func updatePicker(rocketTitles: [String]) {
        picker?.setCollection(rocketTitles)
    }
    
    func updateUIForRocket(_ rocket: Rocket) {
        
        rocketNameLabel.text = rocket.name
        rocketDescriptionLabel.text = rocket.rocketDescription
        
        if let date = rocket.firstFlightDate {
            let dateDescription = DateFormatters.simpleDayMonthYear.getDescription(date)
            firstFlightLabel.text = dateDescription
        }
        
        gallery.images = rocket.images
    }
    
}


