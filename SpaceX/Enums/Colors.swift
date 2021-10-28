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
    
    static let accentOrange: UIColor = UIColor.orange
    
    static let gray: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray6
        } else {
            return UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        }
    }()
    
}
