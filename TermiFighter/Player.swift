//
//  Player.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

class Player {
    var name: String
    var hisChars: [Character]
    var hisEliminatedChars = [Character]()

    init(name: String, hisChars: [Character]) {
        self.name = name
        self.hisChars = hisChars
    }

    convenience init() {
        self.init(name: "", hisChars: [Character]())
    }
}
