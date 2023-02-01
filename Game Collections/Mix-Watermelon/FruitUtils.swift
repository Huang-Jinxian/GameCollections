//
//  FruitUtils.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/29.
//

import SpriteKit

let randomFruitList:[FruitTexture] = [.grape,.cherry,.orange,.lemon,.kiwi]
var randomFruitCount: Int = 0

func randomFruit()->FruitTexture {
    randomFruitCount += 1
    switch randomFruitCount {
    case 1...3:
        return  .grape
    case 4:
        return .cherry
    case 5:
        return .orange
    default:
        return randomFruitList.randomElement()!
    }
}

func generateRandomFruit()->SKSpriteNode {
    let curFruitTexture = randomFruit()
    let fruit = SKSpriteNode(imageNamed: curFruitTexture.name)
    fruit.name = curFruitTexture.name
    fruit.position = CGPoint(x: screen.width/2, y: screen.height - 100)
    fruit.setScale(0.5)
    fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width/2)
    fruit.physicsBody?.isDynamic = false
    fruit.physicsBody?.categoryBitMask = curFruitTexture.bitmask
    fruit.physicsBody?.contactTestBitMask = curFruitTexture.bitmask
    return fruit
}

func mixFruit(curFruitTexture : FruitTexture, position: CGPoint)->SKSpriteNode {
    let mixFruitTexture = curFruitTexture.mix
    let fruit = SKSpriteNode(imageNamed: mixFruitTexture.name)
    fruit.name = mixFruitTexture.name
    fruit.position = position
    fruit.setScale(0.5)
    fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width/2)
    fruit.physicsBody?.categoryBitMask = mixFruitTexture.bitmask
    fruit.physicsBody?.contactTestBitMask = mixFruitTexture.bitmask
    return fruit
}

func getFruitTextureByName(fruitname name: String) -> FruitTexture{
    FruitTexture.allCases.first {$0.name == name}!
}
