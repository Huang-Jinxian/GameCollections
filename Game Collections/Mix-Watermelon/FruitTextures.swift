//
//  FruitTextures.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/29.
//

import Foundation

enum FruitTexture: String, CaseIterable {
    case cherry = "cherry"
    case coconut = "cocount"
    case grape = "grape"
    case halfwatermelon = "halfwatermelon"
    case kiwi = "kiwi"
    case lemon = "lemon"
    case orange = "orange"
    case peach = "peach"
    case pineapple = "pineapple"
    case tomato = "tomato"
    case watermelon = "watermelon"
    
    var name: String {
        rawValue
    }
    
    var bitmask: UInt32 {
        switch self {
        case .cherry :
            return 1<<1
        case .coconut:
            return 1<<2
        case .grape:
            return 1<<3
        case .halfwatermelon:
            return 1<<4
        case .kiwi:
            return 1<<5
        case .lemon:
            return 1<<6
        case .orange:
            return 1<<7
        case .peach:
            return 1<<8
        case .pineapple:
            return 1<<9
        case .tomato:
            return 1<<10
        case .watermelon:
            return 1<<11
        }
    }
    
    var mix: FruitTexture {
        switch self {
        case .grape: return .cherry;
        case .cherry: return .orange;
        case .orange: return .lemon;
        case .lemon: return .kiwi;
        case .kiwi: return .tomato;
        case .tomato: return .peach;
        case .peach: return .pineapple;
        case .pineapple: return .coconut;
        case .coconut: return .halfwatermelon;
        case .halfwatermelon: return .watermelon;
        default: return .grape;
        }
    }
}
