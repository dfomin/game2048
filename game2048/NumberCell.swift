//
//  NumberCell.swift
//  game2048
//
//  Created by Dmitry Fomin on 21/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import Foundation
import SpriteKit

class NumberCell {
    
    // MARK: - Static properties
    
    static var origin = CGPoint(x: 0, y: 0)
    static var cellSize = CGSize(width: 50, height: 50)
    static var border = CGFloat(1)
    
    // MARK: - Properties
    
    private(set) var number: Int {
        didSet {
            label.text = String(number)
        }
    }
    
    private(set) var x: Int
    private(set) var y: Int
    
    private(set) var sprite: SKSpriteNode
    private(set) var label: SKLabelNode
    
    // MARK: - Methods
    
    init(x: Int, y: Int) {
        number = 1
        self.x = x
        self.y = y
        
        sprite = SKSpriteNode(color: UIColor.gray, size: NumberCell.cellSize)
        label = SKLabelNode(text: String(number))
        
        configureLabel()
        
        let position = calculatePosition(x: x, y: y)
        sprite.position = position
    }
    
    // MARK: - Private methods
    
    private func calculatePosition(x: Int, y: Int) -> CGPoint {
        let cellWidth = NumberCell.cellSize.width
        let cellHeight = NumberCell.cellSize.height
        let border = NumberCell.border
        let x = cellWidth / 2 + CGFloat(x) * cellWidth + CGFloat(x + 1) * border + NumberCell.origin.x
        let y = cellHeight / 2 + CGFloat(y) * cellHeight + CGFloat(y + 1) * border + NumberCell.origin.y
        
        return CGPoint(x: x, y: y)
    }
    
    private func configureLabel() {
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        sprite.addChild(label)
    }
}
