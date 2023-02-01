//
//  FruitState.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/30.
//

import GameplayKit
import SpriteKit

// MARK: - FruitStateMachine
class FruitState: GKState {
    unowned var scene: MixWatermelonScene
    
    init(scene: MixWatermelonScene) {
        self.scene = scene
        super.init()
    }
}

class FruitReadyState: FruitState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return  stateClass is FruitFalldownState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
}

class FruitFalldownState: FruitState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FruitReadyState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.curFruit.run(.sequence([
            .moveTo(x: scene.touchLocation.x, duration: 0.1),
            .run {
                self.scene.curFruit.physicsBody = SKPhysicsBody(circleOfRadius: self.scene.curFruit.size.width/2)
                let kind = getFruitTextureByName(fruitname: self.scene.curFruit.name!)
                self.scene.curFruit.physicsBody?.categoryBitMask = kind.bitmask
                self.scene.curFruit.physicsBody?.contactTestBitMask = kind.bitmask
            },
            .wait(forDuration: 0.5),
            .run {
                self.scene.curFruit = generateRandomFruit()
                self.scene.addChild(self.scene.curFruit)
                self.scene.fruitAppear()
            },
            .run {
                self.stateMachine?.enter(FruitReadyState.self)
            }]))
    }
}
