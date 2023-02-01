//
//  FlappyBirdTouches.swift
//  Game Collections
//
//  Created by 黄芹 on 2023/2/1.
//

import SpriteKit

// MARK: - Touches

extension FlappyBirdScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 700)
        flappyBirdFlyStateMachine.enter(FlappyBirdFlyState.self)
    }
}
