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
        guard let gameState = flappyBirdGameStateMachine.currentState else {return}
        
        if gameState.isKind(of: FlappyBirdGameIdleState.self) {
            flappyBirdGameStateMachine.enter(FlappyBirdGameRunningState.self)
        } else if gameState.isKind(of: FlappyBirdGameRunningState.self) {
            bird.physicsBody?.isDynamic = true
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
            flappyBirdFlyStateMachine.enter(FlappyBirdFlyState.self)
        }
    }
}
