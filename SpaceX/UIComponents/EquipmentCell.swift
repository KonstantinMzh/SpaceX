//
//  EquipmentCell.swift
//  SpaceX
//
//  Created by Константин Маламуж on 14.11.2021.
//

import UIKit


class EquipmentCell: UITableViewCell {
    
    static let id = "equipmentCell"
    let attributedString = NSMutableAttributedString(string: "КАПСУЛЫ", attributes: [.kern: 4])


    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 14
        imageView.contentMode = .scaleAspectFill
        if #available(iOS 13.0, *) {
            imageView.layer.cornerCurve = .continuous
        }
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let equipmentNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Colors.white
        label.textAlignment = .right
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setCell() {
        selectionStyle = .none

        contentView.addSubview(coverImageView)
        coverImageView.addSubview(equipmentNameLabel)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            equipmentNameLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -16),
            equipmentNameLabel.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -16)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        equipmentNameLabel.text = nil
        coverImageView.image = nil
    }
    
    func prepareForEquipment(_ equipment: Equipment) {
        coverImageView.image = UIImage(named: equipment.coverName)
        let name = equipment.name.uppercased()
        attributedString.mutableString.setString(name)
        equipmentNameLabel.attributedText = attributedString
    }
    
}
