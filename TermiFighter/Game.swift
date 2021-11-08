//
//  Game.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//
class Game {
    var nbTurns = 0
    var characters = charactersCreation()
    var P1 = Player()
    var P2 = Player()

    enum Team: Int {
        case teamP1 = 1
        case teamP2 = 2
        case noTeam = 3
    }

    init() {
        startGame()
    }

    func startGame() {
        // ----------------------------------------------------------------PLAYER1----------------------------------------------------------------
        //Initialization of player 1
        print("\n")
        print("🕹 Welcome to TermiFighter, the game is about to begin... Player 1, what is your name ? 🕹\n")
        var namePlayer1 = ""

        if let nameOfThePlayer = readLine() {
            namePlayer1 = nameOfThePlayer
            print("\n\n\n")
            print("\n👈 Alright \(namePlayer1), now pick 3 characters, you can modify their names ! 👈\n")
            print("\n")
        }

        // Player1 choose his characters
        let charactersP1 = self.createTeams()
        P1 = Player(name: namePlayer1, hisChars: charactersP1)

        // Display the players's 1 characters
        self.displayChars(chars: charactersP1)

        // ----------------------------------------------------------------PLAYER2----------------------------------------------------------------
        //Initialisation du joueur 2
        print(" -----------------------------")
        print("|Player 2, what is your name ?| \n -----------------------------\n")
        var namePlayer2 = ""

        if let nameOfThePlayer = readLine() {
            namePlayer2 = nameOfThePlayer
            print("\n")
            print("\n👈 Alright \(namePlayer2), now pick 3 characters, you can modify their names ! 👈\n")
            print("\n")
        }

        // Player2 choose his characters
        let charactersP2 = self.createTeams()
        P2 = Player(name: namePlayer2, hisChars: charactersP2)

        // Display the players's 2 characters
        displayChars(chars: charactersP2)

    }

    func createTeams() -> [Character] {

        var charsOfThePlayer = [Character]()
        var character: String?

        // Display of the characters
        self.displayChars(chars: characters)

        // Players chooses their team
        var count = 0

        repeat {
            print("\n -----------")
            print("|Character \(count+1)|\n -----------\n")

            repeat {
                character = readLine()
            } while character!.isEmpty || !controlChar(nameChar: character!, tabChars: characters)
                print("\n -----------------------------------------------")
                print("|Pick his new name, otherwise you can write \"no\"| \n -----------------------------------------------\n")

            var rename: String?

            repeat {
                rename = readLine()
            } while rename!.isEmpty

                    if rename != "no" {

                        charsOfThePlayer.append(self.pickChar(nameChar: character!, tabChars: characters))
                        characters.removeAll { $0.name == character! }
                        charsOfThePlayer[count].name = rename!

                    } else {

                        charsOfThePlayer.append(self.pickChar(nameChar: character!, tabChars: characters))
                        characters.removeAll { $0.name == character! }

                    }

            count += 1

        } while count < 3

        return charsOfThePlayer

    }

    // Affichage du gagnant et du perdant
    func display(winner: Player, loser: Player) {

        print(" 🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇")
        print("\n🥇CONGRATULATIONS \(winner.name)! YOU WON THE GAME IN \(nbTurns) TURNS!🥇\n")
        print(" 🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇🥇\n")

        print("Your characters :\n")
        displayChars(chars: winner.hisChars)

        print("\nCharacters of \(loser.name) :\n")
        displayChars(chars: loser.hisEliminatedChars)
    }

    // Début de l'affrontement
    func startBattle() {
        print("\n------------------GAME START------------------\n")
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

    // Création des personnages du jeu
    static func charactersCreation() -> [Character] {
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

    // Affichage d'un tableau de personnages
    func displayChars(chars: [Character]) {
        for character in chars {
            print("\n\(character.nameEmoji) : \(character.name)",
                  "  ||  \(character.healthEmoji) : \(character.health)  ||  ",
                  "\(character.weapon.image) : \(character.weapon.damages)\n")
        }
    }

    // Contrôle si un personnage est bien dans le tableau
    func controlChar(nameChar: String, tabChars: [Character]) -> Bool {
        return tabChars.contains { theCharacter in
            theCharacter.name == nameChar
        }
    }

    // Retourne le personnage dont le nom match avec le nom passé en paramètre
    func pickChar(nameChar: String, tabChars: [Character]) -> Character {
        return tabChars.first { theCharacter in
            theCharacter.name == nameChar
        }!
    }

    // Permet de savoir si un personnage est dans un des deux tableaux passés en paramètre
    func inTeam(nameChar: String, tab1: [Character], tab2: [Character]) -> Bool {
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

    // Permet de savoir dans quel équipe se trouve le personnage
    func whichTeam(nameChar: String, tab1: [Character], tab2: [Character]) -> Team {
        var result1 = false
        var result2 = false

        result1 = tab1.contains { theChar in
            theChar.name == nameChar
        }

        result2 = tab2.contains { theChar in
            theChar.name == nameChar
        }

        if result1 {
            return Team.teamP1
        } else if result2 {
            return Team.teamP2
        } else {
            return Team.noTeam
        }
    }

    // Le joueur correspondant joue son tour
    func turn(of player: Player, nextPlayer: Player) {

        var characterPicked: Character?
        var characterPicked2 = Character()
        var character: String?

        print("\n▶️ \(player.name), select a character ▶️\n")

        //Affichage des personnages
        displayChars(chars: player.hisChars)

        //Choix du personnage
        repeat {
            character = readLine()
        } while character!.isEmpty || !controlChar(nameChar: character!, tabChars: player.hisChars)

        characterPicked = pickChar(nameChar: character!, tabChars: player.hisChars)

        // Random call for the box
        let call = Bool.random()

        if call {
            let theBox = Box.init()
            print("\n‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️")
            print("‼️SURPRISE! A random box appeared, it contains your new weapon! ‼️")
            print("‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️\n")
            print("\(theBox.image) : \(theBox.damages)")
            characterPicked?.weapon = theBox
        }

        //Choix du personnage cible
        print("\nChoose an ally to heal, or an ennemy to attack!\n")

        repeat {
            character = readLine()
        } while character!.isEmpty || !inTeam(nameChar: character!, tab1: player.hisChars, tab2: nextPlayer.hisChars)

        let team = whichTeam(nameChar: character!, tab1: player.hisChars, tab2: nextPlayer.hisChars)

        if team == Team.teamP1 {

            characterPicked2 = pickChar(nameChar: character!, tabChars: player.hisChars)
            characterPicked!.heal(target: characterPicked2)

        } else if team == Team.teamP2 {

            characterPicked2 = pickChar(nameChar: character!, tabChars: nextPlayer.hisChars)
            characterPicked!.attack(target: characterPicked2)

            if characterPicked2.health <= 0 {
                characterPicked2.health = 0
                nextPlayer.hisEliminatedChars.append(characterPicked2)
                nextPlayer.hisChars.removeAll { $0.name == characterPicked2.name }
            }
        }
    }
}
