//
//  RocketInfoViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import UIKit


class RocketInfoViewController: UIViewController {
    
    var presenter: RocketInfoPresenterProtocol?
    weak var picker: PickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        picker?.setCollection(presenter?.getRocketsTitles() ?? [])

    }
    
}


