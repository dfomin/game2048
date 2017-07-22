//
//  NumberCellDelegate.swift
//  game2048
//
//  Created by Dmitry Fomin on 22/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import Foundation

protocol NumberCellDelegate {
    
    func onCellCreated(x: Int, y: Int)
    func onCellMoved(from oldX: Int, and oldY: Int, to newX: Int, and newY: Int)
}
