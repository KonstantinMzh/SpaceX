//
//  ViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 21.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let spaceService = SpaceService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        spaceService.fetch()

    }


}

