//
//  ViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 28.11.2021.
//

import UIKit


class ViewController: UIViewController {
    
    var isConnected: Bool = true {
        didSet {
            if isConnected != oldValue {
                isConnected ? hideBanner() : showBanner()
            }
        }
    }
    
    let banner: BannerView = {
        let bannerView = BannerView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.message = "Waiting connection"
        return bannerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var hideAnchor: NSLayoutConstraint?
    var showAnchor: NSLayoutConstraint?
    
    func configureViewController() {
        
        guard let navigationController = navigationController else { return }
        navigationController.view.addSubview(banner)
        
        NSLayoutConstraint.activate([
            banner.centerXAnchor.constraint(equalTo: navigationController.view.centerXAnchor),
            banner.widthAnchor.constraint(equalTo: navigationController.view.widthAnchor)
        ])
        
        hideAnchor = banner.bottomAnchor.constraint(equalTo: navigationController.view.topAnchor, constant: 0)
        showAnchor = banner.topAnchor.constraint(equalTo: navigationController.view.topAnchor, constant: 0)

        hideAnchor?.isActive = true
        
    }
    
    func showBanner() {
        hideAnchor?.isActive = false
        showAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.navigationController?.view.layoutIfNeeded()
        }
    }
    
    func hideBanner() {
        showAnchor?.isActive = false
        hideAnchor?.isActive = true

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.navigationController?.view.layoutIfNeeded()
        }
    }

}
