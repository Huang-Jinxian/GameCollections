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
    
    override func didEnter(from previousState: GKState?) {
        bird.physicsBody?.isDynamic = false
    }
}


class FlappyBirdFlyState: FlappyBirdState {
    
    let birdFlyFrames = [SKTexture(imageNamed: "bird/glide"),SKTexture(imageNamed: "bird/fly"),SKTexture(imageNamed: "bird/glide"),SKTexture(imageNamed: "bird/falldown")]
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGlideState.Type || stateClass is FlappyBirdFalldownState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        bird.run(.repeatForever(.animate(with: birdFlyFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey: "flappy-bird-fly")
    }
}

class FlappyBirdFalldownState: FlappyBirdState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGlideState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        bird.removeAction(forKey: "flappy-bird-fly")
    }
}
