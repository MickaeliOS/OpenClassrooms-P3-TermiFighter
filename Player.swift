//
//  Player.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

import Foundation

class Player {
    var name: String
    var tableOfCharacters: [Character]

    init(name: String, tableOfCharacter: [Character]) {
        self.name = name
        self.tableOfCharacters = tableOfCharacter
    }

    func attackOrHeal(charactersP1: [Character], charactersP2: [Character]) {
        var charactersAction = [Character]()
        
        print("Choose a character of yours \n")

        if theGame.whoPlays == "P1" {
            var myCharacterPicked = Character()

            if let character = readLine() {
                charactersAction.append(theGame.pickCharacter(nameOfTheCharacter: character))
                myCharacterPicked = charactersAction[0]
            }

            print("Choose an ennemy to attack or an ally to heal \n")

            print("Your characters \n")
            theGame.displayCharacters(characters: charactersP1)

            print("Ennemy's characters \n")
            theGame.displayCharacters(characters: charactersP2)

            if let character = readLine() {
                for characterInP2 in charactersP2 {
                    if characterInP2.name == character {
                        myCharacterPicked.attack(target: characterInP2)
                    }
                }

                for charactersInP1 in charactersP1 {
                    if charactersInP1.name == character {
                        myCharacterPicked.heal(target: charactersInP1)
                    }
                }
            }
        }

    }
}


