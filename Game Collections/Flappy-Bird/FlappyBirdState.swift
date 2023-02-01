//
//  FlappyBirdState.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/1.
//

import SpriteKit
import GameplayKit

class FlappyBirdState: GKState {
    
    unowned var bird: SKSpriteNode
    
    init(bird: SKSpriteNode) {
        self.bird = bird
        super.init()
    }
}

class FlappyBirdGlideState: FlappyBirdState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdFlyState.Type || stateClass is FlappyBirdFalldownState.Type
    }
}

class FlappyBirdFlyState: FlappyBirdState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGlideState.Type
    }
}

class FlappyBirdFalldownState: FlappyBirdState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGlideState.Type
    }
}
