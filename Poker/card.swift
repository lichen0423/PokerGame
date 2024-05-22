//
//  card.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//

import Foundation

private protocol Deck {
    
    var trumpCards: [TrumpCard] {get}
    
    mutating func drawing(_ number: Int) -> [TrumpCard]
    
    mutating func refill()
    
    mutating func shuffle()
}



struct TrumpCardDeck : Deck {
    
    fileprivate var trumpCards: [TrumpCard] = TrumpCard.whole()
    
    mutating func drawing(_ number: Int) -> [TrumpCard] {
        var cards: [TrumpCard] = []
        for _ in 1...number { cards.append(trumpCards.removeLast()) }
        return cards
    }
    
    mutating func refill() { trumpCards = TrumpCard.whole() }
    
    mutating func shuffle() { trumpCards.shuffle() }
}





struct TrumpCard: Hashable, Comparable  {
    
    let suit: Suit
    
    let rank: Rank
    
    func convert() -> String { rank.convert() + suit.convert() }
    
    static func whole() -> [TrumpCard] {
        var whole: [TrumpCard] = []
        for suit in Suit.allCases() {
            for rank in Rank.allCases() {
                whole.append(TrumpCard(suit: suit, rank: rank))
            }
        }
        return whole
    }
    
    static func < (lhs: TrumpCard, rhs: TrumpCard) -> Bool {
        lhs.rank == rhs.rank ? lhs.suit < rhs.suit : lhs.rank < rhs.rank
    }
}

enum Suit: Int, Comparable {
    case clover  = 1
    case heart   = 2
    case diamond = 3
    case spade   = 4
    
    func convert() -> String {
        switch self {
        case .spade: return "♤"
        case .diamond: return "♦︎"
        case .heart: return "♥︎"
        case .clover: return "♧"
        }
    }
    
    static func < (lhs: Suit, rhs: Suit) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    static func allCases() -> [Suit] {
        [.spade, .diamond, .heart, .spade]
    }
}

enum Rank: Int, Comparable {
    case ace    = 1
    case two    = 2
    case three  = 3
    case four   = 4
    case five   = 5
    case six    = 6
    case seven  = 7
    case eight  = 8
    case nine   = 9
    case ten    = 10
    case j      = 11
    case q      = 12
    case k      = 13
    
    func convert() -> String {
        self == .ace ? "A" : "\(self.rawValue)"
    }
    
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        if lhs == .ace { return false }
        else if rhs == .ace { return true }
        else { return lhs.rawValue < rhs.rawValue }
    }
    
    static func allCases() -> [Rank] {
        [.ace, .two, .three, .four, .five,
         .six, .seven, .eight, .nine, .ten,
         .j, .q, .k]
    }
}

