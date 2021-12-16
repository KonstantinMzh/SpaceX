//
//  RocketPickerViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import UIKit

protocol PickerDelegate: AnyObject {
    func didSelectAtIndex(_ index: Int)
}

class PickerViewController: UIViewController {
    
    //MARK: - Properties
    private var collection: [String] = []
    weak var delegate: PickerDelegate?
    weak var viewController: PickerViewController?
    private var selectedItem = 0 {
        didSet {
            collectionView.scrollToItem(at: IndexPath(item: selectedItem, section: 0), at: .centeredHorizontally, animated: true)
            let oldSelectedCell = collectionView.cellForItem(at: IndexPath(item: oldValue, section: 0)) as? PickerCollectionCell
            oldSelectedCell?.isChoosed = false
            
            let newSelectedCell = collectionView.cellForItem(at: IndexPath(item: selectedItem, section: 0)) as? PickerCollectionCell
            newSelectedCell?.isChoosed = true

            delegate?.didSelectAtIndex(selectedItem)
        }
    }
    
    //MARK: - UI Elements
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PickerCollectionCell.self, forCellWithReuseIdentifier: PickerCollectionCell.pickerCellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = Colors.background
        return collectionView
    }()
    
    func setCollection(_ collection: [String]) {
        self.collection = collection
        collectionView.reloadData()

        if self.collection.count > 0 {
            selectedItem = 0
        }
        
    }
    
    func didSelectAtIndex(_ index: Int) {
        delegate?.didSelectAtIndex(index)
    }
    
    

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.background

        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
    }
    
    func configure() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //MARK: - Child handling
    func addContentController(_ child: UIViewController) {
        addChild(child)
        child.didMove(toParent: self)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

    }
    
}


extension PickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PickerCollectionCell.pickerCellID,
                                                            for: indexPath) as? PickerCollectionCell else { return UICollectionViewCell() }
        cell.prepareCell(collection[indexPath.item])
        cell.isChoosed = indexPath.item == selectedItem
        return cell
    }
    
}


extension PickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.item
    }
    
    
}

