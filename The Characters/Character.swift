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
    var nameEmoji: Any
    var healthEmoji: Any

    init(name: String, health: Int, weapon: Weapon, nameEmoji: Any, healthEmoji: Any) {
        self.name = name
        self.health = health
        self.weapon = weapon
        self.nameEmoji = nameEmoji
        self.healthEmoji = healthEmoji
    }
    
    convenience init() {
        self.init(name: "", health: 0, weapon: Bow(), nameEmoji: "", healthEmoji: "")
    }

    func attack(target: Character) {
        target.health -= self.weapon.damages
    }

    func heal(target: Character) {
        target.health += self.weapon.damages
    }


}
