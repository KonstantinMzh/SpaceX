//
//  LaunchDetailViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.11.2021.
//

import UIKit
import SpaceSDK
import Gallery


class LaunchDetailViewController: UIViewController {
    
    //MARK: - Propeties
    var presenter: LaunchDetailPresenterProtocol?
    var displayLink: CADisplayLink?

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
        stackView.spacing = 25
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: - Rows
    let descriptionRow = DescriptionRow()
    let gallery = Gallery()
    let launchRocketAndTimeRow = LaunchRocketAndTimeRow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchLaunch()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeTimer()
    }
    
    
    //MARK: - Configure
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
        
        stackView.addArrangedSubview(launchRocketAndTimeRow)
        stackView.addArrangedSubview(descriptionRow)


    }
    
    func updateUIForLaunch(_ launch: Launch) {
        gallery.removeFromSuperview()
        
        launchDate = launch.date

        launchRocketAndTimeRow.timerLabel.text = Date().getRemainTimeBeforeEvent(eventDate: launch.date)
        
        let dateDiff = launch.date - Date().timeIntervalSince1970 >= 0
        var launchState: LaunchState = .unknown
        
        switch (dateDiff, launch.success) {
        case (true, _):
            launchState = .unknown
            descriptionRow.setText(launch.details ?? "Description will appear after launch")

        case (false, false):
            launchState = .failure
            descriptionRow.setText(launch.details ?? "No description")

        case (false, true):
            launchState = .success
            descriptionRow.setText(launch.details ?? "No description")

        default:
            launchState = .unknown
            descriptionRow.setText(launch.details ?? "No description")
            launchRocketAndTimeRow.timerLabel.text = "00:00:00"
        }

        launchRocketAndTimeRow.prepareForLaunch(launch, rocketName: "Empty Rocket", state: launchState)
        
        if let images = launch.links?.flickr?.original, images.count > 0 {
            stackView.addArrangedSubview(gallery)
            gallery.images = launch.links?.flickr?.original ?? []
        }
        
        stackView.addArrangedSubview(UIView())

    }
    
    func createTimer() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateLink))
        displayLink?.preferredFramesPerSecond = 10
        displayLink?.add(to: .main, forMode: .common)
    }
    
    var launchDate: TimeInterval?

    func removeTimer() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc func updateLink() {
        guard let launchDate = launchDate else { return }

        
        let remainTimeDescription = Date().getRemainTimeBeforeEvent(eventDate: launchDate)
        launchRocketAndTimeRow.timerLabel.text = remainTimeDescription
        let diffTimeInterval = launchDate - Date().timeIntervalSince1970

        if diffTimeInterval <= 0 {
//            delegate?.launchHappened()
            return
        }


    }
    
    
    //MARK: - Init
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
