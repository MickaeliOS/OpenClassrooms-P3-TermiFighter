//
//  Player.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

class Player {
    var name: String
    var tableOfCharacters: [Character]

    init(name: String, tableOfCharacter: [Character]) {
        self.name = name
        self.tableOfCharacters = tableOfCharacter
    }

    convenience init() {
        self.init(name: "", tableOfCharacter: [Character]())
    }
}
