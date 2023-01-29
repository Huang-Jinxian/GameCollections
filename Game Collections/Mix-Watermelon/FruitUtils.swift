//
//  FruitUtils.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/29.
//

import SpriteKit

func generateRandomFruit()->SKSpriteNode {
    let fruit = SKSpriteNode(imageNamed: "grape")
    fruit.position = CGPoint(x: screen.width/2, y: screen.height - 100)
    fruit.setScale(0.5)
    return fruit
}
