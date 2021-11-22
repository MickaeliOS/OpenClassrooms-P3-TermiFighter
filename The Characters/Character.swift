//
//  Character.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

class Character {
    var name: String
    var health: Int
    private let maxHealth: Int
    var weapon: Weapon
    let nameEmoji: String
    let healthEmoji: String

    init(name: String, health: Int, maxHealth: Int, weapon: Weapon, nameEmoji: String, healthEmoji: String) {
        self.name = name
        self.health = health
        self.maxHealth = maxHealth
        self.weapon = weapon
        self.nameEmoji = nameEmoji
        self.healthEmoji = healthEmoji
    }
    
    convenience init() {
        self.init(name: "", health: 0, maxHealth: 0, weapon: Bow(), nameEmoji: "", healthEmoji: "")
    }

    func attack(target: Character) {
        target.health -= self.weapon.damages
    }

    func heal(target: Character) {
        if target.health == target.maxHealth {
            print("\n‼️Heal failed, this character already have all his HP‼️\n")
            return

        } else if target.maxHealth < target.health + self.weapon.damages {

            target.health = target.maxHealth

        } else {

            target.health += self.weapon.damages

        }
    }
}
