//
//  Game.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

class Game {
    var nbTurns = 0
    //var winner: Player
    var charactersTable = charactersCreation()
    var eliminatedCharacterP1 = [Character]()
    var eliminatedCharacterP2 = [Character]()
    var Player1 = Player()
    var Player2 = Player()

    init() {
        startGame()
    }

    func startGame() {
        // ----------------------------------------------------------------PLAYER1----------------------------------------------------------------

        //Initialization of player 1
        print("Welcome to TermiFighter, the game is about to begin... Player 1, what is your name ? \n")
        var namePlayer1 = ""

        if let nameOfThePlayer = readLine() {
            namePlayer1 = nameOfThePlayer
            print("\nAlright \(namePlayer1), now pick 3 characters, you can modify their names ! \n")
        }

        // Player1 choose his characters
        let charactersP1 = self.createTeams()
        Player1 = Player(name: namePlayer1, tableOfCharacter: charactersP1)

        // Display the players's 1 characters
        self.displayCharacters(characters: charactersP1)

        // ----------------------------------------------------------------PLAYER2----------------------------------------------------------------

        //Initialisation du joueur 2
        print("\nPlayer 2, what is your name ? \n")
        var namePlayer2 = ""

        if let nameOfThePlayer = readLine() {
            namePlayer2 = nameOfThePlayer
            print("\nAlright \(namePlayer2), now pick 3 characters, you can modify their names ! \n")
        }

        // Player2 choose his characters
        let charactersP2 = self.createTeams()
        Player2 = Player(name: namePlayer2, tableOfCharacter: charactersP2)

        // Display the players's 2 characters
        displayCharacters(characters: charactersP2)

        // Display the rest of the characters
        print("\nRESTE DES PERSONNAGES\n")
        displayCharacters(characters: charactersTable)

    }

    func createTeams() -> [Character] {

        var charactersOfThePlayer = [Character]()

        // Display of the characters
        self.displayCharacters(characters: charactersTable)

        // Players chooses their team

        var count = 0

        repeat {
            print("\nCharacter \(count+1) : \n")

            if let character = readLine(), !character.isEmpty, controlCharacter(nameOfTheCharacter: character, tableOfCharacters: charactersTable) {
                print("Pick his new name, otherwise you can write \"no\" \n")

                if let rename = readLine() {
                    if rename != "no" {
                        charactersOfThePlayer.append(self.pickCharacter(nameOfTheCharacter: character, charactersTable: self.charactersTable))
                        removeFromTab(nameOfCharacter: character, tableOfCharacters: &charactersTable)
                        charactersOfThePlayer[count].name = rename
                    } else {
                        charactersOfThePlayer.append(self.pickCharacter(nameOfTheCharacter: character, charactersTable: self.charactersTable))
                        removeFromTab(nameOfCharacter: character, tableOfCharacters: &charactersTable)
                    }
                }
            }

            count += 1

        } while count < 3

        return charactersOfThePlayer

    }

    func display() {
        if Player1.tableOfCharacters.isEmpty {
            print("***************************************************")
            print("\nCONGRATULATIONS \(Player2.name)! YOU WON THE GAME IN \(nbTurns) TURNS!")
            print("***************************************************\n")

            print("Your characters :\n")
            displayCharacters(characters: Player2.tableOfCharacters)

            print("\nCharacters of \(Player1.name)\n")
            displayCharacters(characters: eliminatedCharacterP1)
        } else if Player2.tableOfCharacters.isEmpty {
            print("***************************************************")
            print("\nCONGRATULATIONS \(Player1.name)! YOU WON THE GAME IN \(nbTurns) TURNS!\n")
            print("***************************************************\n")

            print("Your characters :\n")
            displayCharacters(characters: Player1.tableOfCharacters)


            print("\nCharacters of \(Player2.name)\n")
            displayCharacters(characters: eliminatedCharacterP2)
        }
    }

    func startBattle() {
        repeat {
            nbTurns += 1
            print("\n------------------GAME START------------------\n")

            // -------------------------------------------------------------PLAYER1-------------------------------------------------------------
            print("\(Player1.name), select a character\n")
            displayCharacters(characters: Player1.tableOfCharacters)
            var characterPicked = Character()
            var characterPicked2 = Character()
            var character: String?


            repeat {
                character = readLine()
            } while character!.isEmpty && controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player1.tableOfCharacters)

            // Player1 choose his character
            characterPicked = pickCharacter(nameOfTheCharacter: character!, charactersTable: Player1.tableOfCharacters)

            print("Choose an ally to heal, or an ennemy to attack!\n")
            repeat {
                character = readLine()
            } while character!.isEmpty && (controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player1.tableOfCharacters) || controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player2.tableOfCharacters))

            if controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player1.tableOfCharacters) {

                characterPicked2 = pickCharacter(nameOfTheCharacter: character!, charactersTable: Player1.tableOfCharacters)
                characterPicked.heal(target: characterPicked2)

            } else if controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player2.tableOfCharacters) {

                characterPicked2 = pickCharacter(nameOfTheCharacter: character!, charactersTable: Player2.tableOfCharacters)
                print(characterPicked2.health)
                characterPicked.attack(target: characterPicked2)
                print(characterPicked2.health)

                if characterPicked2.health <= 0 {
                    eliminatedCharacterP2.append(characterPicked2)
                    removeFromTab(nameOfCharacter: characterPicked2.name, tableOfCharacters: &Player2.tableOfCharacters)
                    if Player2.tableOfCharacters.isEmpty {
                        display()
                        break
                    }
                }
            }

            // -------------------------------------------------------------PLAYER2-------------------------------------------------------------
            print("\(Player2.name), select a character\n")
            displayCharacters(characters: Player2.tableOfCharacters)

            repeat {
                character = readLine()
            } while character!.isEmpty && controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player1.tableOfCharacters)

            // Player1 choose his character
            characterPicked = pickCharacter(nameOfTheCharacter: character!, charactersTable: Player1.tableOfCharacters)

            print("\nChoose an ally to heal, or an ennemy to attack!\n")

            repeat {
                character = readLine()
            } while character!.isEmpty && (controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player1.tableOfCharacters) || controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player2.tableOfCharacters))

            if controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player2.tableOfCharacters) {

                characterPicked2 = pickCharacter(nameOfTheCharacter: character!, charactersTable: Player2.tableOfCharacters)
                characterPicked.heal(target: characterPicked2)

            } else if controlCharacter(nameOfTheCharacter: character!, tableOfCharacters: Player1.tableOfCharacters) {

                characterPicked2 = pickCharacter(nameOfTheCharacter: character!, charactersTable: Player1.tableOfCharacters)
                characterPicked.attack(target: characterPicked2)

                if characterPicked2.health <= 0 {
                    eliminatedCharacterP1.append(characterPicked2)
                    removeFromTab(nameOfCharacter: characterPicked2.name, tableOfCharacters: &Player1.tableOfCharacters)
                    if Player1.tableOfCharacters.isEmpty {
                        display()
                        break
                    }
                }
            }

        } while true
    }

    static func charactersCreation() -> [Character] {
        var charactersTable = [Character]()

        charactersTable.append(Character(name: "Eddy", health: 800, weapon: .gun))
        charactersTable.append(Character(name: "Carol", health: 950, weapon: .gun))
        charactersTable.append(Character(name: "Fred", health: 1290, weapon: .bow))
        charactersTable.append(Character(name: "Celine", health: 300, weapon: .shotgun))
        charactersTable.append(Character(name: "Boris", health: 659, weapon: .gun))
        charactersTable.append(Character(name: "Chris", health: 2000, weapon: .sword))
        charactersTable.append(Character(name: "Bob", health: 4, weapon: .shotgun))
        charactersTable.append(Character(name: "Terry", health: 9, weapon: .bow))
        charactersTable.append(Character(name: "Eva", health: 7, weapon: .gun))

        return charactersTable
    }

    func displayCharacters(characters: [Character]) {
        for character in characters {
            print("Name : \(character.name) // Health : \(character.health) // Weapon : \(character.weapon)")
            print("-----------------------------------------------")
        }
    }

    func controlCharacter(nameOfTheCharacter: String, tableOfCharacters: [Character]) -> Bool {
        for character in tableOfCharacters {
            if character.name == nameOfTheCharacter {
                return true
            }
        }
        return false
    }

    func pickCharacter(nameOfTheCharacter: String, charactersTable: [Character]) -> Character {
        let theCharacter = Character()

        for character in charactersTable {
            if character.name == nameOfTheCharacter {
                return character
            }
        }

        return theCharacter
    }

    func removeFromTab(nameOfCharacter: String, tableOfCharacters: inout [Character]) {
        for i in 0..<tableOfCharacters.count {
            if nameOfCharacter == tableOfCharacters[i].name {
                tableOfCharacters.remove(at: i)
                return
            }
        }
    }
}
