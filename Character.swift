//
//  Character.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

import Foundation

class Character {
    var name: String = ""
    var health: Int = 0
    var weapon: Int = 0

    enum turn {
        case P1, P2
    }

    init(theName: String, theHealth: Int, theWeapon: Int) {
        name = theName
        health = theHealth
        weapon = theWeapon
    }

    convenience init() {
        self.init(theName: "", theHealth: 0, theWeapon: 0)
    }

    func attack(target: Character) {
        target.health -= self.weapon
    }

    func heal(target: Character) {
        target.health += self.weapon
    }
}
