//
//  Card.swift
//  EmojiStack
//
//  Created by Tom Seymour on 12/22/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

class Card {
    let value: Int
    let suit: String
    var inDeck: Bool
    
    init(value: Int, suit: String, inDeck: Bool = true) {
        self.value = value
        self.suit = suit
        self.inDeck = inDeck
    }
    
    class func emojiDeck() -> [Card] {
        let suits: [String] = ["😀", "🍏", "🚗", "🐬"]
        let values: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        var emojiDeck: [Card] = []
        for suit in suits {
            for value in values {
                emojiDeck.append(Card(value: value, suit: suit))
            }
        }
        return emojiDeck
    }
}
