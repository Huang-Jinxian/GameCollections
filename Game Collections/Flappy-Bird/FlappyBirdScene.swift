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
    var floor: SKNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    var pipes:[SKSpriteNode] = []
    
    lazy var flappyBirdFlyStateMachine = GKStateMachine(states: [FlappyBirdGlideState(bird: self.bird),FlappyBirdFlyState(bird: self.bird)])
    lazy var flappyBirdFloorStateMachine = GKStateMachine(states: [FlappyBirdFloorStaticState(floor: floor),FlappyBirdFloorRunState(floor: floor)])
    
    override func didMove(to view: SKView) {
        
        loadUI()
        
        flappyBirdFlyStateMachine.enter(FlappyBirdGlideState.self)
        flappyBirdFloorStateMachine.enter(FlappyBirdFloorStaticState.self)
    }
    
    override func update(_ currentTime: TimeInterval) {

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
        floor = childNode(withName: "floor")
        floor1 = floor.childNode(withName: "floor1") as? SKSpriteNode
        floor2 = floor.childNode(withName: "floor2") as? SKSpriteNode
        
        bird.physicsBody = SKPhysicsBody(texture: bird.texture!, size: bird.size)
        
        floor1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: floor1.size.height), to:  CGPoint(x: floor1.size.width, y: floor1.size.height))
        floor2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: floor2.size.height), to:  CGPoint(x: floor2.size.width, y: floor2.size.height))
        
    }
    
    func randomPips() {
        let high = self.size.height - floor1.size.height
        let width = CGFloat(60)
        
        let pipGap = CGFloat(arc4random_uniform(UInt32(bird.size.height))) + bird.size.height * 2.5
        
        let topPipHeight = CGFloat(arc4random_uniform(UInt32(high - pipGap)))
        let bottomPipHeight = high - pipGap - pipGap
        createPips(topSize: CGSize(width: width, height: topPipHeight), bottomSize: CGSize(width: width, height: bottomPipHeight))
    }
    
    func createPips(topSize: CGSize, bottomSize: CGSize) {
        let topPip = SKSpriteNode(imageNamed: "pip/top")
        topPip.size = topSize
        topPip.physicsBody = SKPhysicsBody(texture: topPip.texture!, size: topPip.texture!.size())
        topPip.physicsBody?.isDynamic = false
        topPip.physicsBody?.categoryBitMask = 1<<1
        topPip.physicsBody?.contactTestBitMask = 1<<1
        topPip.position = CGPoint(x: self.size.width + topSize.width/2, y: self.size.height - topSize.height/2)
        addChild(topPip)
        
        let bottomPip = SKSpriteNode(imageNamed: "pip/bottom")
        bottomPip.size = bottomSize
        bottomPip.physicsBody = SKPhysicsBody(texture: bottomPip.texture!, size: bottomPip.texture!.size())
        bottomPip.physicsBody?.isDynamic = false
        bottomPip.physicsBody?.categoryBitMask = 1<<1
        bottomPip.physicsBody?.contactTestBitMask = 1<<1
        bottomPip.position = CGPoint(x: self.size.width + bottomSize.width/2, y: bottomSize.height/2)
        addChild(bottomPip)
    }
}

struct FlappyBirdScene_Previews: PreviewProvider {
    static var previews: some View {
        SpriteView(scene: FlappyBirdScene.newScene())
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}
