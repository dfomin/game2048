//
//  GameScene.swift
//  game2048
//
//  Created by Dmitry Fomin on 21/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, NumberCellDelegate {
    
    // MARK: - Private properties
    
    private var field: GameField!
    private var fieldView = [NumberCell?]()
    private var cellWidth: CGFloat!
    private var cellHeight: CGFloat!
    
    private let width = 4
    private let height = 4
    private let border = CGFloat(10)
    
    // MARK: - SKScene
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        assert(view.bounds.width < view.bounds.height)
        let shift = (view.bounds.height - view.bounds.width) / 2
        let origin = CGPoint(x: view.bounds.origin.x, y: view.bounds.origin.y + shift)
        let size = CGSize(width: view.bounds.width, height: view.bounds.width)
        
        fieldView = [NumberCell?](repeating: nil, count: width * height)
        
        cellWidth = (size.width - border * CGFloat(width + 1)) / CGFloat(width)
        cellHeight = (size.height - border * CGFloat(height + 1)) / CGFloat(height)
        
        generateBorders(origin: origin, size: size, width: width, height: height, border: border)
        
        NumberCell.origin = origin
        NumberCell.cellSize = CGSize(width: cellWidth, height: cellHeight)
        NumberCell.border = border
        NumberCell.screenHeight = view.bounds.height
        
        field = GameField(width: width, height: height, delegate: self)
        
        field.createCell()
        field.createCell()
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - NumberCellDelegate
    
    func onCellCreated(at index: Int) {
        let x = index % width
        let y = index / width
        
        print("new \(x),\(y)")
        
        let newCell = NumberCell(x: x, y: y, number: field.numbers[index])
        fieldView[index] = newCell
        addChild(newCell.sprite)
        
        newCell.sprite.setScale(0.1)
        newCell.sprite.run(SKAction.scale(to: 1, duration: 0.2))
    }
    
    func onCellMoved(from oldIndex: Int, to newIndex: Int) {
        let oldX = oldIndex % width
        let oldY = oldIndex / width
        let newX = newIndex % width
        let newY = newIndex / width
        
        print("move \(oldX),\(oldY) \(newX),\(newY)")
        
        let oldPosition = fieldView[oldIndex]!.sprite.position
        
        fieldView[newIndex] = fieldView[oldIndex]
        fieldView[newIndex]!.updatePosition(newX: newX, newY: newY)
        fieldView[oldIndex] = nil
        
        let newPosition = fieldView[newIndex]!.sprite.position
        let sprite = fieldView[newIndex]!.sprite
        
        sprite.position = oldPosition
        sprite.run(SKAction.move(to: newPosition, duration: 0.2))
    }
    
    func onNumberUp(at index: Int) {
        let x = index % width
        let y = index / width
        
        print("up \(x),\(y)")
        
        fieldView[index]!.updateNumber(newNumber: field.numbers[index])
    }
    
    func onRemove(from oldIndex: Int, to newIndex: Int) {
        let oldX = oldIndex % width
        let oldY = oldIndex / width
        let newX = newIndex % width
        let newY = newIndex / width
        
        print("remove \(oldX),\(oldY) \(newX),\(newY)")
        
        let sprite = fieldView[oldIndex]!.sprite
        let oldPosition = sprite.position
        fieldView[oldIndex]!.updatePosition(newX: newX, newY: newY)
        let newPosition = sprite.position
        sprite.position = oldPosition
        sprite.run(SKAction.sequence([SKAction.move(to: newPosition, duration: 0.2), SKAction.removeFromParent()]))
    }
    
    // MARK: - Methods
    
    func swipe(_ direction: Direction) {
        if field.check(direction: direction) {
            field.move(direction: direction)
            
            field.createCell()
            if field.checkEnd() {
                print("END")
            }
        }
    }
    
    // MARK: - Private methods
    
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
