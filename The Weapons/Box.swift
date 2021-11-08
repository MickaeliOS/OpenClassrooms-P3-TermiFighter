//
//  Box.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 08/11/2021.
//

import Foundation

class Box: Weapon {
    let weapons = ["Bow", "Gun", "Bomb", "Sword"]
    
    init() {
        let randomWeapon = weapons.randomElement()!

        switch randomWeapon {
            case "Bow":
                super.init(name: "Bow", damages: 150, image: "🏹")
                break
            case "Gun":
                super.init(name: "Gun", damages: 150, image: "🔫")
                break
            case "Bomb":
                super.init(name: "Bomb", damages: 200, image: "💣")
                break
            case "Sword":
                super.init(name: "Sword", damages: 100, image: "🗡")
                break
            default:
                super.init(name: "", damages: 0, image: "")
        }
    }
}
