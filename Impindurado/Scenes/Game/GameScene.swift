//
//  GameScene.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 12/08/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    lazy var sceneCamera: SKCameraNode = {
        let camera = SKCameraNode()
        camera.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        return camera
    }()

    override func didMove(to view: SKView) {

    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
