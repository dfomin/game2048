//
//  GameScene.swift
//  game2048
//
//  Created by Dmitry Fomin on 21/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        print("didMove")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("touchDown")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print("touchMoved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("touchUp")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
