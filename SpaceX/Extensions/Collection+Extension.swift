//
//  Collection+Extension.swift
//  SpaceX
//
//  Created by Константин Маламуж on 29.10.2021.
//

import Foundation


extension Collection {

    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}
