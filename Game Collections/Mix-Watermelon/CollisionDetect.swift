//
//  CollisionDetect.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/30.
//

import SpriteKit

// MARK: - collsion detect
extension MixWatermelonScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node!
        let nodeB = contact.bodyB.node!
        groundFruits.insert(nodeA)
        groundFruits.insert(nodeB)
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        for fruit in FruitTexture.allCases {
            let fruitBit = fruit.bitmask | fruit.bitmask
            if fruitBit == collision {
                let newFruitPosition = CGPoint(
                    x: (nodeA.position.x + nodeB.position.x)/2,
                    y: (nodeA.position.y+nodeB.position.y)/2)
                
                run(.sequence([
                    .run {
                        nodeA.run(.fadeOut(withDuration: 0.1))
                        nodeB.run(.fadeOut(withDuration: 0.1))
                    },
                    .run {
                        nodeA.removeFromParent()
                        nodeB.removeFromParent()
                        self.groundFruits.remove(nodeA)
                        self.groundFruits.remove(nodeB)
                    },
                    .run {
                        let mixFruit = mixFruit(curFruitTexture: fruit, position: newFruitPosition)
                        self.groundFruits.insert(mixFruit)
                        self.addChild(mixFruit)
                        mixFruit.setScale(0)
                        mixFruit.run(.scale(to: 0.5, duration: 0.1))
                    }
                ]))
                break
            }
        }
    }
}
