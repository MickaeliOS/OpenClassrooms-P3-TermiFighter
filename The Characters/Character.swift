//
//  Character.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

class Character {
    var name: String
    var health: Int
    var weapon: Weapon

    init(name: String, health: Int, weapon: Weapon) {
        self.name = name
        self.health = health
        self.weapon = weapon
    }
    
    convenience init() {
        self.init(name: "", health: 0, weapon: Bow())
    }

    func attack(target: Character) {
        target.health -= self.weapon.damages
    }

    func heal(target: Character) {
        target.health += self.weapon.damages
    }


}
