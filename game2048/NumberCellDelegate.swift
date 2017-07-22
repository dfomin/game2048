//
//  NumberCellDelegate.swift
//  game2048
//
//  Created by Dmitry Fomin on 22/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import Foundation

protocol NumberCellDelegate {
    
    func onCellCreated(at index: Int)
    func onCellMoved(from oldIndex: Int, to newIndex: Int)
    func onNumberUp(at index: Int)
    func onRemove(from oldIndex: Int, to newIndex: Int)
}
