//
//  GameViewController.swift
//  game2048
//
//  Created by Dmitry Fomin on 21/07/2017.
//  Copyright © 2017 Dmitry Fomin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var scene: GameScene!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func onSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        scene.swipe(.left)
    }
    
    @IBAction func onSwipeRight(_ sender: UISwipeGestureRecognizer) {
        scene.swipe(.right)
    }
    
    @IBAction func onSwipeUp(_ sender: UISwipeGestureRecognizer) {
        scene.swipe(.up)
    }
    
    @IBAction func onSwipeDown(_ sender: UISwipeGestureRecognizer) {
        scene.swipe(.down)
    }
}
