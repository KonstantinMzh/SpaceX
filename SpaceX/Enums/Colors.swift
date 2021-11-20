//
//  Colors.swift
//  SpaceX
//
//  Created by Константин Маламуж on 23.10.2021.
//

import UIKit


enum Colors {
    
    static let background: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.systemBackground
        } else {
            return UIColor.white
        }
    }()
    
    static let contrast: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.black
        }
    }()
    
    static let contrastText: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return UIColor.white
        }
    }()
    
    static let mainAccent: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemIndigo
        } else {
            return UIColor.systemBlue
        }
    }()
    
    static let black: UIColor = .black
    static let white: UIColor = .white
    
    static let gray: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray6
        } else {
            return UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        }
    }()
    
    static let secondaryLabel: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor(red: 0.52, green: 0.52, blue: 0.55, alpha: 1.00)
        }
    }()
    
    static let label: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.white
        }
    }()
    
    static let gray6: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray6
        } else {
            return UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        }
    }()
    
    static let gray5: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray5
        } else {
            return UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)
        }
    }()
    
}
