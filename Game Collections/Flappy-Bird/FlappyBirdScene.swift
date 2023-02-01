//
//  FlappyBirdScene.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/1.
//

import SwiftUI
import SpriteKit
import GameplayKit

class FlappyBirdScene: SKScene {
    
    var bird: SKSpriteNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    
    lazy var flappyBirdFlyStateMachine = GKStateMachine(states: [FlappyBirdGlideState(bird: self.bird),FlappyBirdFlyState(bird: self.bird)])

    
    override func didMove(to view: SKView) {
        loadUI()
        
        flappyBirdFlyStateMachine.enter(FlappyBirdGlideState.self)
    }
    
    class func newScene() -> FlappyBirdScene {
        let scene = FlappyBirdScene(fileNamed: "FlappyBirdScene")!
        scene.scaleMode = .aspectFill
        return scene
    }
}

// MARK: - LoadUI
extension FlappyBirdScene {
    func loadUI() {
        bird = childNode(withName: "bird") as? SKSpriteNode
        floor1 = childNode(withName: "floor1") as? SKSpriteNode
        floor2 = childNode(withName: "floor2") as? SKSpriteNode
        
        bird.physicsBody = SKPhysicsBody(texture: bird.texture!, size: bird.size)
        
        floor1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: floor1.size.height), to:  CGPoint(x: floor1.size.width, y: floor1.size.height))
        floor2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: floor2.size.height), to:  CGPoint(x: floor2.size.width, y: floor2.size.height))
        
    }
}

struct FlappyBirdScene_Previews: PreviewProvider {
    static var previews: some View {
        SpriteView(scene: FlappyBirdScene.newScene())
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}
