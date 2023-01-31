//
//  MainMenuScene.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/31.
//

import SwiftUI
import SpriteKit

class MainMenuScene: SKScene {
    
    var mixWatermelonLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        loadUI()
    }
    
    class func newScene() -> MainMenuScene {
        let scene = MainMenuScene()
        scene.size = CGSize(width: screen.width, height: screen.height)
        return scene
    }
}

// MARK: - Load UI
extension MainMenuScene {
    func loadUI(){
        let background = SKSpriteNode(color: #colorLiteral(red: 0.9887889028, green: 0.9229483604, blue: 0.7085906863, alpha: 1),size: CGSize(width: screen.width, height: screen.height))
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
        
        mixWatermelonLabel = SKLabelNode(text: NSLocalizedString("app_name_mix_watermelon", comment: ""))
        mixWatermelonLabel.fontColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        mixWatermelonLabel.position = CGPoint(x: screen.width/2, y: screen.height - screen.height/5)
        addChild(mixWatermelonLabel)
    }

}

// MARK: - Touches
extension MainMenuScene {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        for node in self.nodes(at: location) {
            if node == mixWatermelonLabel {
                self.view?.presentScene(MixWatermelonScene.newScene())
                return
            }
        }
    }
}

struct MainMenuScene_Previews: PreviewProvider {
    static var previews: some View {
        SpriteView(scene: MainMenuScene.newScene())
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}
