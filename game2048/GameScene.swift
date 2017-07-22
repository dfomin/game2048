//
//  GameScene.swift
//  game2048
//
//  Created by Dmitry Fomin on 21/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Private properties
    
    private var cells = [NumberCell]()
    
    // MARK: - SKScene
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        assert(view.bounds.width < view.bounds.height)
        let shift = (view.bounds.height - view.bounds.width) / 2
        print("\(shift) \(view.bounds.height) \(view.bounds.width)")
        let origin = CGPoint(x: view.bounds.origin.x, y: view.bounds.origin.y + shift)
        let size = CGSize(width: view.bounds.width, height: view.bounds.width)
        
        generateBorders(origin: origin, size: size, width: 4, height: 4, border: 10)
        //generateField(origin: origin, size: size, width: 4, height: 4, border: 10)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - Private methods
    
    private func generateField(origin: CGPoint, size: CGSize, width: Int, height: Int, border: CGFloat) {
        let cellWidth = (size.width - border * CGFloat(width + 1)) / CGFloat(width)
        let cellHeight = (size.height - border * CGFloat(height + 1)) / CGFloat(height)
        
        NumberCell.origin = origin
        NumberCell.cellSize = CGSize(width: cellWidth, height: cellHeight)
        NumberCell.border = border
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let cell = NumberCell(x: x, y: y)
                cells.append(cell)
                
                addChild(cell.sprite)
            }
        }
    }
    
    private func generateBorders(origin: CGPoint, size: CGSize, width: Int, height: Int, border: CGFloat) {
        for i in 0 ... width {
            let sprite = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: border, height: size.height))
            let x = CGFloat(i) * (size.width - border) / CGFloat(width) + border * 0.5 + origin.x
            sprite.position = CGPoint(x: x, y: size.height / 2 + origin.y)
            addChild(sprite)
        }
        
        for i in 0 ... height {
            let sprite = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: size.width, height: border))
            let y = CGFloat(i) * (size.height - border) / CGFloat(height) + border * 0.5 + origin.y
            sprite.position = CGPoint(x: size.width / 2 + origin.x, y: y)
            addChild(sprite)
        }
    }
}
