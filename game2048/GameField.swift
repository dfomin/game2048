//
//  GameField.swift
//  game2048
//
//  Created by Dmitry Fomin on 22/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import Foundation

class GameField {
    
    // MARK: - Private properties
    
    private(set) var numbers: [Int]
    private var width: Int
    private var height: Int
    private var delegate: NumberCellDelegate
    
    // MARK: - Methods
    
    init(width: Int, height: Int, delegate: NumberCellDelegate) {
        self.width = width
        self.height = height
        self.delegate = delegate
        
        numbers = [Int](repeating: 0, count: width * height)
    }
    
    func createCell() {
        let freeCount = numbers.filter{ $0 == 0 }.count
        assert(freeCount > 0)
        let index = Int(arc4random_uniform(UInt32(freeCount)))
        var count = 0
        var realIndex: Int?
        for i in 0 ..< width * height {
            if numbers[i] == 0 {
                if count == index {
                    realIndex = i
                    break
                }
                
                count += 1
            }
        }
        
        assert(realIndex != nil)
        
        createCell(index: realIndex!)
    }
    
    func move(direction: Direction) {
        assert(check(direction: direction))
        
        let arrays = createArrays(for: direction)
        
        for array in arrays {
            var i = 0
            var startIndex = 0
            while i < array.count {
                let index = array[i]
                var newIndex = index
                if numbers[index] != 0 {
                    if startIndex < i {
                        for j in (startIndex ..< i).reversed() {
                            let prevIndex = array[j]
                            if numbers[prevIndex] == 0 {
                                newIndex = prevIndex
                            } else if numbers[prevIndex] == numbers[index] {
                                newIndex = prevIndex
                                startIndex = j + 1
                            } else {
                                break
                            }
                        }
                    }
                    
                    if newIndex != index {
                        moveCell(from: index, to: newIndex)
                    }
                }
                
                i += 1
            }
        }
    }
    
    func checkEnd() -> Bool {
        return !check(direction: .up) && !check(direction: .down) && !check(direction: .left) && !check(direction: .right)
    }
    
    func check(direction: Direction) -> Bool {
        let arrays = createArrays(for: direction)
        
        return check(arrays)
    }
    
    // MARK: - Private methods
    
    private func check(_ arrays: [[Int]]) -> Bool {
        for array in arrays {
            var thereWasEmptyCell = false
            var lastNumber = 0
            for index in array {
                let number = numbers[index]
                if number == 0 {
                    thereWasEmptyCell = true
                } else {
                    if thereWasEmptyCell {
                        return true
                    }
                    
                    if lastNumber == number {
                        return true
                    } else {
                        lastNumber = number
                    }
                }
            }
        }
        
        return false
    }
    
    private func createCell(index: Int) {
        numbers[index] = arc4random_uniform(4) == 0 ? 4 : 2
        
        delegate.onCellCreated(at: index)
    }
    
    private func moveCell(from oldIndex: Int, to newIndex: Int) {
        if numbers[newIndex] != 0 {
            numbers[newIndex] *= 2
            numbers[oldIndex] = 0
            
            delegate.onNumberUp(at: newIndex)
            delegate.onRemove(from: oldIndex, to: newIndex)
        } else {
            numbers[newIndex] = numbers[oldIndex]
            numbers[oldIndex] = 0
            
            delegate.onCellMoved(from: oldIndex, to: newIndex)
        }
    }
    
    private func createArrays(for direction: Direction) -> [[Int]] {
        var arrays = [[Int]]()
        
        switch direction {
        case .left:
            for y in 0 ..< height {
                var array = [Int]()
                for x in 0 ..< width {
                    array.append(y * width + x)
                }
                arrays.append(array)
            }
        case .right:
            for y in 0 ..< height {
                var array = [Int]()
                for x in (0 ..< width).reversed() {
                    array.append(y * width + x)
                }
                arrays.append(array)
            }
        case .up:
            for x in 0 ..< width {
                var array = [Int]()
                for y in 0 ..< height {
                    array.append(y * width + x)
                }
                arrays.append(array)
            }
        case .down:
            for x in 0 ..< width {
                var array = [Int]()
                for y in (0 ..< height).reversed() {
                    array.append(y * width + x)
                }
                arrays.append(array)
            }
        }
        
        return arrays
    }
}
