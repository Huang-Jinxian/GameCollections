//
//  FlappyBirdGameState.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/2.
//

import GameplayKit

class FlappyBirdGameState: GKState {
    
    unowned var scene: FlappyBirdScene
    
    init(scene: FlappyBirdScene) {
        self.scene = scene
        super.init()
    }
}

class FlappyBirdGameIdleState: FlappyBirdGameState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGameRunningState.Type
    }
}

class FlappyBirdGameRunningState: FlappyBirdGameState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGameOverState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.flappyBirdFlyStateMachine.enter(FlappyBirdFlyState.self)
        scene.flappyBirdFloorStateMachine.enter(FlappyBirdFloorRunState.self)
    }
}

class FlappyBirdGameOverState: FlappyBirdGameState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGameIdleState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.flappyBirdFloorStateMachine.enter(FlappyBirdFloorStaticState.self)
        scene.flappyBirdFlyStateMachine.enter(FlappyBirdFalldownState.self)
    }
}
