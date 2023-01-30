//
//  MixWatermelonScene.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/29.
//

import SwiftUI
import SpriteKit
import GameplayKit

let screen = UIScreen.main.bounds
class MixWatermelonScene: SKScene, SKPhysicsContactDelegate {
    
    var curFruit: SKSpriteNode!
    var ground: SKSpriteNode!
    var groundFruits:[SKSpriteNode] = []
    
    var touchLocation: CGPoint!
    lazy var gameStateMachine: GKStateMachine = GKStateMachine(states: [FruitReadyState(scene: self),FruitFalldownState(scene: self)])
    
    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        makeUI()
        
        curFruit = generateRandomFruit()
        addChild(curFruit)
        gameStateMachine.enter(FruitReadyState.self)
    }
    
    class func newScene() -> SKScene{
        let scene = MixWatermelonScene()
        scene.size = CGSize(width: screen.width, height: screen.height)
        return scene
    }
    
}

// MARK: - MakeUI
extension MixWatermelonScene {
    func makeUI() {
        let background = SKSpriteNode(color: #colorLiteral(red: 0.9887889028, green: 0.9229483604, blue: 0.7085906863, alpha: 1),size: CGSize(width: screen.width, height: screen.height))
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
        
        let solid = SKSpriteNode(color: #colorLiteral(red: 0.4588235294, green: 0.3333333333, blue: 0.2352941176, alpha: 1),size: CGSize(width: screen.width, height: screen.height/5))
        solid.anchorPoint = CGPoint.zero
        solid.position = CGPoint.zero
        addChild(solid)
        
        ground = SKSpriteNode(color: #colorLiteral(red: 0.6745098039, green: 0.537254902, blue: 0.3490196078, alpha: 1),size: CGSize(width: screen.width, height: 10))
        ground.anchorPoint = CGPoint.zero
        ground.position = CGPoint(x: 0, y: solid.size.height)
        ground.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: ground.size.height), to: CGPoint(x: ground.size.width, y: ground.size.height))
        addChild(ground)
    }
    
    func fruitAppear(){
        curFruit.setScale(0)
        curFruit.run(.scale(to: 0.5, duration: 0.1))
    }
}

// MARK: - Touches
extension MixWatermelonScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touchLocation = touch.location(in: self)
        gameStateMachine.enter(FruitFalldownState.self)
//        curFruit.run(.sequence([
//            .moveTo(x: self.touchLocation.x, duration: 0.1),
//            .run {
//                self.curFruit.physicsBody?.isDynamic = true
//            },
//            .wait(forDuration: 0.5),
//            .run {
//                self.curFruit = generateRandomFruit()
//                self.addChild(self.curFruit)
//                self.fruitAppear()
//            }]))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

struct MixWatermelonScene_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
