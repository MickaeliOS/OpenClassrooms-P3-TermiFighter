//
//  Weapon.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 20/10/2021.
//

import Foundation

class Weapon {
    var name: String
    var damages: Int
    var image: Any

    init(name: String, damages: Int, image: Any) {
        self.name = name
        self.damages = damages
        self.image = image
    }
}

/*class arme {
    nom
    damages
}

class bow: arme {
    super.init
}
*/
