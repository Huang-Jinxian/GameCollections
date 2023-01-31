//
//  FruitRedlineState.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/31.
//

import GameplayKit

class FruitRedlineShowingState: FruitState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FruitRedlineDisappearState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        self.scene.redline.setScale(1)
    }
}

class FruitRedlineDisappearState: FruitState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FruitRedlineShowingState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        self.scene.redline.setScale(0)
    }
}
