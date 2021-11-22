//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 12.11.2021.
//

import UIKit


class LaunchesViewController: UIViewController {
    
    var presenter: LaunchesPresenterProtocol?

    //MARK: - UI-Components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(FutureLaunchCell.self, forCellReuseIdentifier: FutureLaunchCell.id)
        tableView.register(OldLaunchCell.self, forCellReuseIdentifier: OldLaunchCell.id)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchLaunches()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeTimer()
    }
    
    func configure() {
        title = "Launches"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = Colors.background
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func updateUI() {
        tableView.reloadData()
        createTimer()
    }
    
    func createTimer() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateLink))
        displayLink?.preferredFramesPerSecond = 10
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func removeTimer() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc func updateLink() {
        let indexPaths = tableView.indexPathsForVisibleRows?.filter { $0.section == 0 }
        for indexPath in indexPaths ?? [] {
            if let cell = tableView.cellForRow(at: indexPath) as? FutureLaunchCell {
                cell.updateTimer()
            }
        }
        
    }
    
}


extension LaunchesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfElementsForSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let launch = presenter?.getLaunchAtIndexPath(indexPath) else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FutureLaunchCell.id, for: indexPath) as? FutureLaunchCell else { return UITableViewCell() }
            cell.prepareForLaunch(launch)
            
            presenter?.getTitleForRocketWithId(launch.rocketId, completion: { result in
                switch result {
                case .success(let rocketName):
                    cell.setRocketName(rocketName)
                case .failure(_):
                    break
                }
            })
            
            cell.delegate = self
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OldLaunchCell.id, for: indexPath) as? OldLaunchCell else { return UITableViewCell() }
            cell.prepareForLaunch(launch)
            
            presenter?.getTitleForRocketWithId(launch.rocketId, completion: { result in
                switch result {
                case .success(let rocketName):
                    cell.setRocketName(rocketName)
                case .failure(_):
                    break
                }
            })
            
            return cell
            
        default:
            return UITableViewCell()

        }
    }
    
}

extension LaunchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = presenter?.getLaunchIdByIndexPath(indexPath),
              let title = presenter?.getLaunchNameByIndexPath(indexPath) else { return }
        presenter?.showLaunchDetailScreen(id, title: title)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LaunchHeaderView()
        switch section {
        case 0:
            headerView.titleLabel.text = "Future"
        case 1:
            headerView.titleLabel.text = "Past"
        default:
            break
        }
        
        return headerView
    }
    
}


extension LaunchesViewController: LaunchDelegate {
    func launchHappened() {
        removeTimer()
        presenter?.fetchLaunches()
    }
}
