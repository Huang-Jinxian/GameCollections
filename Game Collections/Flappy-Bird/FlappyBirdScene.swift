//
//  FlappyBirdScene.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/2/1.
//

import SwiftUI
import SpriteKit

class FlappyBirdScene: SKScene {
    
    var bird: SKSpriteNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        
    }
    
    class func newScene() -> FlappyBirdScene {
        let scene = FlappyBirdScene(fileNamed: "FlappyBirdScene")!
        scene.scaleMode = .aspectFill
        return scene
    }
}

// MARK: - LoadUI
extension FlappyBirdScene {
    func loadUI() {
        bird = childNode(withName: "bird") as! SKSpriteNode
        floor1 = childNode(withName: "floor1") as! SKSpriteNode
        floor2 = childNode(withName: "floor2") as! SKSpriteNode
    }
}

struct FlappyBirdScene_Previews: PreviewProvider {
    static var previews: some View {
        SpriteView(scene: FlappyBirdScene.newScene())
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}
