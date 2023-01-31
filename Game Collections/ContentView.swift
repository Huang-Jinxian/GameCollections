//
//  ContentView.swift
//  Game Collections
//
//  Created by 黄金先 on 2023/1/29.
//

import SwiftUI
import SpriteKit

let screen = UIScreen.main.bounds

struct ContentView: View {
    var body: some View {
        SpriteView(scene: MainMenuScene.newScene())
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
