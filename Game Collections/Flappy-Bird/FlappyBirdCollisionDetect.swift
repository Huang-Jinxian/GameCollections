//
//  FlappyBirdCollisionDetect.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/17.
//

import Foundation
import SpriteKit

let BIT_MASK_BIRD:UInt32 = 1 << 1
let BIT_MASK_FLOOR:UInt32 = 1 << 2
let BIT_MASK_PIP:UInt32 = 1 << 3
let COLLISION_BIRD_FLOOR:UInt32 = BIT_MASK_BIRD | BIT_MASK_FLOOR
let COLLISION_BIRD_PIP:UInt32 = BIT_MASK_BIRD | BIT_MASK_PIP

// MARK: - Collision detect
extension FlappyBirdScene {
    func didBegin(_ contact: SKPhysicsContact) {
        let collisionMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collisionMask == COLLISION_BIRD_FLOOR || collisionMask == COLLISION_BIRD_PIP {
            flappyBirdGameStateMachine.enter(FlappyBirdGameOverState.self)
        }
    }
}
