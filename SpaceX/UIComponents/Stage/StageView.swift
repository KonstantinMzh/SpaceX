//
//  StageView.swift
//  SpaceX
//
//  Created by Константин Маламуж on 18.11.2021.
//

import UIKit


class StageView: UIView {
    
    var offset: CGFloat = 0 {
        didSet {
            offsetChanged(offset)
        }
    }
    
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Offset Handler
    func offsetChanged(_ newOffset: CGFloat) {
        
    }
    
}
