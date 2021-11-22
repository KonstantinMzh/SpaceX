//
//  EquipmentsViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 14.11.2021.
//

import UIKit


class EquipmentsViewController: UIViewController {
    
    var presenter: EquipmentsPresenterProtocol?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EquipmentCell.self, forCellReuseIdentifier: EquipmentCell.id)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavigationBar(title: "Equipments", preferredLargeTitle: true)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)


    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func configure() {
        title = "Equipments"
        
        view.backgroundColor = Colors.background
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
}


extension EquipmentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberOfEquipments() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentCell.id,
                                                       for: indexPath) as? EquipmentCell else { return UITableViewCell() }
        if let equipment = presenter?.getEquipmentAtRow(indexPath.row) {
            cell.prepareForEquipment(equipment)
        }
        
        return cell
    }
    
}


extension EquipmentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showEquipmentViewController(indexPath.row)
    }
    
}





