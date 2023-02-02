//
//  FlappyBirdFloorState.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/2.
//

import SpriteKit
import GameplayKit

class FlappyBirdFloorState: GKState {
    
    unowned var floor: SKNode
    unowned var floor1: SKSpriteNode
    unowned var floor2: SKSpriteNode
    let path: CGMutablePath = CGMutablePath()
    let pathLength: CGFloat
    
    init(floor: SKNode) {
        self.floor = floor
        self.floor1 = floor.childNode(withName: "floor1") as! SKSpriteNode
        self.floor2 = floor.childNode(withName: "floor2") as! SKSpriteNode
        
        pathLength = floor1.size.width
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: -pathLength, y: 0))
        super.init()
    }
}

class FlappyBirdFloorStaticState: FlappyBirdFloorState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdFloorRunState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        floor.removeAction(forKey: "flappy-bird-floor-run")
    }
}

class FlappyBirdFloorRunState: FlappyBirdFloorState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdFloorStaticState.Type
    }
    override func didEnter(from previousState: GKState?) {
        
        floor.run(
            .repeatForever(.sequence([
            .follow( path, asOffset: true, orientToPath: false ,speed: 200),
            .run {
                self.floor.position = CGPoint(x: self.floor.position.x + self.pathLength, y: self.floor.position.y)
            }
        ])), withKey: "flappy-bird-floor-run")
    }
}
