//
//  Weapon.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 20/10/2021.
//

import Foundation

class Weapon {
    private let name: String
    let damages: Int
    let image: String

    init(name: String, damages: Int, image: String) {
        self.name = name
        self.damages = damages
        self.image = image
    }
}
