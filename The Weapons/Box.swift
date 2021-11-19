//
//  Box.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 08/11/2021.
//

import Foundation

class Box: Weapon {

    private enum Weapons: CaseIterable {
        case Bow
        case Gun
        case Bomb
        case Sword
    }
    
    init() {
        let weapons = Weapons.allCases.randomElement()!

        switch weapons {
            case .Bow:
                super.init(name: "Bow", damages: 150, image: "🏹")
            case .Gun:
                super.init(name: "Gun", damages: 150, image: "🔫")
            case .Bomb:
                super.init(name: "Bomb", damages: 200, image: "💣")
            case .Sword:
                super.init(name: "Sword", damages: 100, image: "🗡")
        }
    }
}
