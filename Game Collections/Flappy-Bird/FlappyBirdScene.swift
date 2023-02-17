//
//  FlappyBirdScene.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/1.
//

import SwiftUI
import SpriteKit
import GameplayKit

class FlappyBirdScene: SKScene, SKPhysicsContactDelegate{
    
    var bird: SKSpriteNode!
    var floor: SKNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    var pipes:[SKSpriteNode] = []
    
    lazy var flappyBirdGameStateMachine = GKStateMachine(states: [FlappyBirdGameIdleState(scene: self), FlappyBirdGameRunningState(scene: self), FlappyBirdGameOverState(scene: self)])
    lazy var flappyBirdFlyStateMachine = GKStateMachine(states: [FlappyBirdGlideState(bird: self.bird),FlappyBirdFlyState(bird: self.bird)])
    lazy var flappyBirdFloorStateMachine = GKStateMachine(states: [FlappyBirdFloorStaticState(floor: floor),FlappyBirdFloorRunState(floor: floor)])
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        loadUI()
        
        flappyBirdGameStateMachine.enter(FlappyBirdGameIdleState.self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        pipes.forEach({ pip in
            pip.position = CGPoint(x: pip.position.x - 1, y: pip.position.y)
        })
    }
        
    
    class func newScene() -> FlappyBirdScene {
        let scene = FlappyBirdScene(fileNamed: "FlappyBirdScene")!
        scene.scaleMode = .aspectFit
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
        bird.physicsBody?.categoryBitMask = BIT_MASK_BIRD
        bird.physicsBody?.contactTestBitMask = BIT_MASK_FLOOR | BIT_MASK_PIP
        
        floor1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: floor1.size.height), to:  CGPoint(x: floor1.size.width, y: floor1.size.height))
        floor1.physicsBody?.categoryBitMask = BIT_MASK_FLOOR
        floor1.physicsBody?.contactTestBitMask = BIT_MASK_BIRD
        
        floor2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: floor2.size.height), to:  CGPoint(x: floor2.size.width, y: floor2.size.height))
        floor2.physicsBody?.categoryBitMask = BIT_MASK_FLOOR
        floor2.physicsBody?.contactTestBitMask = BIT_MASK_BIRD
    }
    
    func randomPips() {
        let high = self.size.height - floor1.size.height
        let width = CGFloat(80)
        
        let pipGap = CGFloat(arc4random_uniform(UInt32(bird.size.height))) + bird.size.height * 5.5
        
        let topPipHeight = CGFloat(arc4random_uniform(UInt32(high - pipGap)))
        let bottomPipHeight = high - pipGap - topPipHeight
        createPips(topSize: CGSize(width: width, height: topPipHeight), bottomSize: CGSize(width: width, height: bottomPipHeight))
    }
    
    func createPips(topSize: CGSize, bottomSize: CGSize) {
        let topTexture = SKTexture(imageNamed: "pipe/top")
        let topPip = SKSpriteNode(texture: topTexture, size: topSize)
        topPip.physicsBody = SKPhysicsBody(texture: topTexture, size: topSize)
        topPip.physicsBody?.isDynamic = false
        topPip.physicsBody?.categoryBitMask = BIT_MASK_PIP
        topPip.physicsBody?.contactTestBitMask = BIT_MASK_FLOOR
        topPip.position = CGPoint(x: self.size.width + topSize.width/2, y: self.size.height - topSize.height/2)
        addChild(topPip)
        pipes.append(topPip)
        
        let bottomTexture = SKTexture(imageNamed: "pipe/bottom")
        let bottomPip = SKSpriteNode(texture: bottomTexture, size: bottomSize)
        bottomPip.physicsBody = SKPhysicsBody(texture: bottomTexture, size: bottomSize)
        bottomPip.physicsBody?.isDynamic = false
        bottomPip.physicsBody?.categoryBitMask = 1<<3
        bottomPip.physicsBody?.contactTestBitMask = 1<<1
        bottomPip.position = CGPoint(x: self.size.width + bottomSize.width/2, y: floor1.size.height + bottomSize.height/2)
        addChild(bottomPip)
        pipes.append(bottomPip)
    }
}

struct FlappyBirdScene_Previews: PreviewProvider {
    static var previews: some View {
        SpriteView(scene: FlappyBirdScene.newScene())
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}
