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
    
    override func didEnter(from previousState: GKState?) {
        scene.pipes.forEach({pip in
            pip.removeFromParent()
        })
        scene.pipes.removeAll()
    }
}

class FlappyBirdGameRunningState: FlappyBirdGameState {
    var timer: Timer?
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FlappyBirdGameOverState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.flappyBirdFlyStateMachine.enter(FlappyBirdFlyState.self)
        scene.flappyBirdFloorStateMachine.enter(FlappyBirdFloorRunState.self)
        timer = Timer(timeInterval: 2, repeats: true, block: {_ in self.scene.randomPips()})
        timer?.fire()
    }
    
    override func willExit(to nextState: GKState) {
        timer?.invalidate()
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
