//
//  main.swift
//  TermiFighter
//
//  Created by Mickaël Horn on 11/10/2021.
//

import Foundation

let theGame = Game.init()

// -------------------------------------------------------------------PLAYER1-------------------------------------------------------------------

//Initialization of player 1
print("Welcome to TermiFighter, the game is about to begin... Player 1, what is your name ? \n")
var namePlayer1 = ""

if let nameOfP1 = readLine() {
    namePlayer1 = nameOfP1
    print("\nAlright \(namePlayer1), now pick 3 characters, you can modify their names ! \n")
}

// Display of the characters
theGame.displayCharacters(characters: theGame.charactersTable)

// Player1 choose his characters
var charactersP1 = [Character]()
charactersP1 = theGame.charactersChoices(charactersOfThePlayer: charactersP1)

var player1 = Player(name: namePlayer1, tableOfCharacter: charactersP1)

// Display the players's 1 characters
theGame.displayCharacters(characters: charactersP1)

// -------------------------------------------------------------------PLAYER2-------------------------------------------------------------------

//Initialisation du joueur 2
print("\nPlayer 2, what is your name ? \n")
var namePlayer2 = ""

if let nameOfP2 = readLine() {
    namePlayer2 = nameOfP2
    print("\nAlright \(namePlayer2), now pick 3 characters, you can modify their names ! \n")
}

// Display of the characters
theGame.displayCharacters(characters: theGame.charactersTable)

// Player2 choose his characters
var charactersP2 = [Character]()
charactersP2 = theGame.charactersChoices(charactersOfThePlayer: charactersP2)

var player2 = Player(name: namePlayer2, tableOfCharacter: charactersP2)

// Display the players's 2 characters
theGame.displayCharacters(characters: charactersP2)

// Display the rest of the characters
print("\nRESTE DES PERSONNAGES\n")
theGame.displayCharacters(characters: theGame.charactersTable)

// -------------------------------------------------------------------GAME START-------------------------------------------------------------------
print("---------------GAME START---------------")
