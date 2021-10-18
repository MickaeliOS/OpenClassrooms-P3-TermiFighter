//
//  Game.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

import Foundation

class Game {
    //var box: Int = 0
    var charactersTable = [Character]()
    var numberOfTurns = 0
    var whoPlays = "P1"

    init() {
        charactersTable = Game.charactersCreation()
    }

    static func charactersCreation() -> [Character] {
        var charactersTable = [Character]()

        charactersTable.append(Character(theName: "Eddy", theHealth: 800, theWeapon: 217))
        charactersTable.append(Character(theName: "Carol", theHealth: 950, theWeapon: 188))
        charactersTable.append(Character(theName: "Fred", theHealth: 1290, theWeapon: 150))
        charactersTable.append(Character(theName: "Celine", theHealth: 300, theWeapon: 500))
        charactersTable.append(Character(theName: "Boris", theHealth: 659, theWeapon: 280))
        charactersTable.append(Character(theName: "Chris", theHealth: 2000, theWeapon: 90))
        charactersTable.append(Character(theName: "Bob", theHealth: 400, theWeapon: 470))
        charactersTable.append(Character(theName: "Terry", theHealth: 900, theWeapon: 200))
        charactersTable.append(Character(theName: "Eva", theHealth: 687, theWeapon: 260))

        return charactersTable
    }

    func pickCharacter(nameOfTheCharacter: String) -> Character {
        let theCharacter = Character()

        for character in self.charactersTable {
            if character.name == nameOfTheCharacter {
                return character
            }
        }

        return theCharacter
    }

    func controlCharacter(nameOfTheCharacter: String) -> Bool {
        for character in self.charactersTable {
            if character.name == nameOfTheCharacter {
                return true
            }
        }

        return false
    }

    func charactersChoices(charactersOfThePlayer: [Character]) -> [Character] {
        var newCharactersOfThePlayer = charactersOfThePlayer

        // Players chooses their team

        for i in 0..<3 {
            print("\nCharacter \(i+1) : \n")

            if let character = readLine(), !character.isEmpty {
                /*while character.isEmpty {
                    print("Error, name cannot be empty \n")
                }*/

                if self.controlCharacter(nameOfTheCharacter: character) {

                    print("Pick his new name, otherwise you can write \"no\" \n")

                    if let rename = readLine() {
                        if rename != "no" {
                            newCharactersOfThePlayer.append(self.pickCharacter(nameOfTheCharacter: character))
                            self.removeFromTab(nameOfCharacter: character)
                            newCharactersOfThePlayer[i].name = rename
                        } else {
                            newCharactersOfThePlayer.append(self.pickCharacter(nameOfTheCharacter: character))
                            self.removeFromTab(nameOfCharacter: character)
                        }
                    }

                }
            }
        }
        return newCharactersOfThePlayer
    }

    func displayCharacters(characters: [Character]) {
        for character in characters {
            print("Name : \(character.name) // Health : \(character.health) // Weapon : \(character.weapon)")
            print("-----------------------------------------------")
        }
    }

    func removeFromTab(nameOfCharacter: String) {
        for i in 0..<self.charactersTable.count {
            if nameOfCharacter == self.charactersTable[i].name {
                self.charactersTable.remove(at: i)
                return
            }
        }
    }

    
}
