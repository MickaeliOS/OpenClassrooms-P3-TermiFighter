//
//  Game.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//
class Game {
    private var nbTurns = 0
    private var characters = charactersCreation()
    private var P1 = Player()
    private var P2 = Player()

    private enum Team {
        case team1
        case team2
        case noTeam
    }

    init() {
        startGame()
    }

    private func startGame() {
        // ----------------------------------------------------------------PLAYER1----------------------------------------------------------------
        // Player1's Initialization
        print("\n")
        print("🕹 Welcome to TermiFighter, the game is about to begin... Player 1, what is your name ? 🕹\n")
        var namePlayer1: String?

        namePlayer1 = readLine()

        while namePlayer1!.allSatisfy({ $0.isWhitespace }) {
            print("‼️Name cannot be empty, try again!‼️\n")
            namePlayer1 = readLine()
        }

        print("\n\n👈 Alright \(namePlayer1!), now pick 3 characters! 👈\n\n")

        // Player1 choose his characters
        let charactersP1 = self.createTeams()
        P1 = Player(name: namePlayer1!, hisChars: charactersP1)

        // Display the players's 1 characters
        print("\n ---------------------")
        print("|Player 1's characters|")
        print(" ---------------------\n")
        self.displayChars(chars: charactersP1)

        // ----------------------------------------------------------------PLAYER2----------------------------------------------------------------
        // Player2's Initialization
        print("\n -----------------------------")
        print("|Player 2, what is your name ?| \n -----------------------------\n")
        var namePlayer2: String?

        namePlayer2 = readLine()

        while namePlayer2!.allSatisfy({ $0.isWhitespace }) {
            print("‼️Name cannot be empty, try again!‼️\n")
            namePlayer2 = readLine()
        }

        print("\n👈 Alright \(namePlayer2!), now pick 3 characters, you can modify their names ! 👈\n")

        // Player2 choose his characters
        let charactersP2 = self.createTeams()
        P2 = Player(name: namePlayer2!, hisChars: charactersP2)

        // Display the players's 2 characters
        print("\n ---------------------")
        print("|Player 2's characters|")
        print(" ---------------------\n")
        displayChars(chars: charactersP2)

    }

    // Creation of the teams
    private func createTeams() -> [Character] {

        var charsOfThePlayer = [Character]()
        var character: String?
        var rename: String?

        // Display of the characters
        self.displayChars(chars: characters)

        // Players chooses their team
        var count = 0

        repeat {
            print("\n   -----------")
            print("🖋|Character \(count+1)|🖋\n   -----------\n")

            character = readLine()

            while character!.allSatisfy({ $0.isWhitespace }) || !controlChar(nameChar: character!, tabChars: characters) {
                print("‼️This character doesn't exist, try again!‼️")

                print("\n   -----------")
                print("🖋|Character \(count+1)|🖋\n   -----------\n")

                character = readLine()
            }

            print("\n🖋You must choose another name!🖋\n")
            rename = readLine()

            while rename!.allSatisfy({ $0.isWhitespace }) || verifyName(name: rename!, tab: charsOfThePlayer) {
                if verifyName(name: rename!, tab: charsOfThePlayer) {
                    print("‼️\nThis name is already used, pick another one!‼️\n")
                } else {
                    print("‼️Name cannot be empty, try again!‼️\n")
                }
                rename = readLine()
            }

            charsOfThePlayer.append(self.pickChar(nameChar: character!, tabChars: characters))
            characters.removeAll { $0.name == character! }
            charsOfThePlayer[count].name = rename!

            count += 1

        } while count < 3

        return charsOfThePlayer
    }

    // Display of the winner / loser and game stats
    private func display(winner: Player, loser: Player) {

        print(" \n  🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇")
        print("\n🥇 CONGRATULATIONS \(winner.name)! YOU WON THE GAME IN \(nbTurns) TURNS!🥇\n")
        print(" 🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇\n\n")

        print("Your characters :\n")
        displayChars(chars: winner.hisChars)

        print("\nCharacters of \(loser.name) :\n")
        displayChars(chars: loser.hisEliminatedChars)
    }

    // Let the fight begins!
    func startBattle() {
        print("\n💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥")
        print("💥                GAME START              💥")
        print("💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥\n")

        repeat {
            nbTurns += 1

            turn(of: P1, nextPlayer: P2)

                if P2.hisChars.isEmpty {

                    display(winner: P1, loser: P2)
                    break
                }
            
            turn(of: P2, nextPlayer: P1)

                if P1.hisChars.isEmpty {

                    display(winner: P2, loser: P1)
                    break

                }
        } while true
    }

    // Creation of the game's characters
    private static func charactersCreation() -> [Character] {
        var charactersTable = [Character]()

        charactersTable.append(Eddy())
        charactersTable.append(Carol())
        charactersTable.append(Fred())
        charactersTable.append(Celine())
        charactersTable.append(Boris())
        charactersTable.append(Chris())
        charactersTable.append(Bob())
        charactersTable.append(Terry())
        charactersTable.append(Eva())

        return charactersTable
    }

    // Display a table of characters
    private func displayChars(chars: [Character]) {
        for character in chars {
            print("\n\(character.nameEmoji) : \(character.name)",
                  "  ||  \(character.healthEmoji) : \(character.health)  ||  ",
                  "\(character.weapon.image) : \(character.weapon.damages)\n")
        }
    }

    // Control if a character is in the table
    private func controlChar(nameChar: String, tabChars: [Character]) -> Bool {
        return tabChars.contains { theCharacter in
            theCharacter.name == nameChar
        }
    }

    // Return the character with the name in parameter
    private func pickChar(nameChar: String, tabChars: [Character]) -> Character {
        return tabChars.first { theCharacter in
            theCharacter.name == nameChar
        }!
    }

    // This function allows us to know if a character is in one of the two parameter's table
    private func inTeam(nameChar: String, tab1: [Character], tab2: [Character]) -> Bool {
        var result1 = false
        var result2 = false

        result1 = tab1.contains { theChar in
            theChar.name == nameChar
        }

        result2 = tab2.contains { theChar in
            theChar.name == nameChar
        }

        return result1 || result2
    }

    // In which team is the character ?
    private func whichTeam(nameChar: String, tab1: [Character], tab2: [Character]) -> Team {
        var result1 = false
        var result2 = false

        result1 = tab1.contains { theChar in
            theChar.name == nameChar
        }

        result2 = tab2.contains { theChar in
            theChar.name == nameChar
        }

        if result1 {
            return Team.team1
        } else if result2 {
            return Team.team2
        } else {
            return Team.noTeam
        }
    }

    // First parameter is the player who need to play his turn
    private func turn(of player: Player, nextPlayer: Player) {

        var characterPicked: Character?
        var characterPicked2 = Character()
        var character: String?

        print("\n▶️ \(player.name), select a character ▶️\n")

        displayChars(chars: player.hisChars)

        character = readLine()

        while character!.allSatisfy({ $0.isWhitespace }) || !controlChar(nameChar: character!, tabChars: player.hisChars) {
            print("‼️This character doesn't exist, try again!‼️\n")
            character = readLine()
        }

        characterPicked = pickChar(nameChar: character!, tabChars: player.hisChars)

        // Random call for the box
        let call = Bool.random()

        if call {
            let theBox = Box()
            print("\n‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️")
            print("‼️SURPRISE! A random box appeared, it contains your new weapon! ‼️")
            print("‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️\n")
            print("\(theBox.image) : \(theBox.damages)")
            characterPicked?.weapon = theBox
        }

        // Target choice
        print("\n   ❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️")
        print("❤️⚔️ Choose an ally to heal, or an ennemy to attack! ⚔️❤️")
        print("   ❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️⚔️❤️\n")

        character = readLine()

        while character!.isEmpty || !inTeam(nameChar: character!, tab1: player.hisChars, tab2: nextPlayer.hisChars) {
            print("‼️This character doesn't exist, try again!‼️\n")
            character = readLine()
        }

        let team = whichTeam(nameChar: character!, tab1: player.hisChars, tab2: nextPlayer.hisChars)

        if team == Team.team1 {

            characterPicked2 = pickChar(nameChar: character!, tabChars: player.hisChars)
            characterPicked!.heal(target: characterPicked2)
            displayChars(chars: player.hisChars)

        } else if team == Team.team2 {

            characterPicked2 = pickChar(nameChar: character!, tabChars: nextPlayer.hisChars)
            characterPicked!.attack(target: characterPicked2)

            if characterPicked2.health <= 0 {
                characterPicked2.health = 0
                nextPlayer.hisEliminatedChars.append(characterPicked2)
                nextPlayer.hisChars.removeAll { $0.name == characterPicked2.name }
            }
        }
    }

    // We verify if the name already exist or not
    private func verifyName(name: String, tab: [Character]) -> Bool {
        var exist = false

        exist = characters.contains(where: { character in
            character.name == name
        })

        exist = exist || tab.contains(where: { character in
            character.name == name
        })

        exist = exist || P1.hisChars.contains(where: { character in
            character.name == name
        })

        return exist
    }
}
