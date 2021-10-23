//
//  PickerCollectionCell.swift
//  SpaceX
//
//  Created by Константин Маламуж on 23.10.2021.
//

import UIKit


class PickerCollectionCell: UICollectionViewCell {
    
    static let pickerCellID = "pickerCellID"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = Colors.contrastText
        return label
    }()
    
    var isChoosed: Bool = false {
        didSet {
            contentView.backgroundColor = isChoosed ? Colors.accentOrange : Colors.gray
            label.textColor = isChoosed ? Colors.contrastText : Colors.contrast
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.addSubview(label)
        
        contentView.backgroundColor = Colors.contrast
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        isChoosed = false
//    }
    
    func prepareCell(_ title: String) {
        label.text = title
    }
    
}
