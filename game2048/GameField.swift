//
//  GameField.swift
//  game2048
//
//  Created by Dmitry Fomin on 22/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import Foundation

class GameField {
    
    private var numbers: [Int]
    private var width: Int
    private var height: Int
    
    private var delegate: NumberCellDelegate
    
    init(width: Int, height: Int, delegate: NumberCellDelegate) {
        self.width = width
        self.height = height
        self.delegate = delegate
        
        numbers = [Int](repeating: 0, count: width * height)
        
        let index1 = Int(arc4random_uniform(UInt32(width * height)))
        var index2 = Int(arc4random_uniform(UInt32(width * height - 1)))
        if index2 >= index1 {
            index2 += 1
        }
        
        createCell(index: index1)
        createCell(index: index2)
    }
    
    private func createCell(index: Int) {
        numbers[index] = 1
        
        delegate.onCellCreated(x: index % width, y: index / width)
    }
}
