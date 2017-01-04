//
//  ViewController.swift
//  EmojiStack
//
//  Created by Tom Seymour on 12/20/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class EmojiCardViewController: UIViewController {
    
    var drawCardButton: UIButton = UIButton(type: .system)
    var removeRandomButton: UIButton = UIButton(type: .system)
    var showStackButton: UIButton = UIButton(type: .system)
    var removeAllButton: UIButton = UIButton(type: .system)
    var emptyStackBox: UIView = UIView()
    var emptyStackLabel: UILabel = UILabel()
    
    var displayedCardView: EmojiCardView!
    var card: Card!
    var emojiDeck: [Card] = []
    var firstTime = true
    var cardCount = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpNavBar()
        setUpButtons()
        setUpEmptyStackView()
        displayCard()
        if firstTime {
            loadNewDeck()
        } else {
            print(">>> Card count: \(cardCount)")
        }
    }
    
    func setUpNavBar() {
        navigationItem.title = "Emoji Stack"
        if card != nil {
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Remove", style: UIBarButtonItemStyle.plain, target: self, action: #selector(navBack))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
    }
    
    func navBack() {
        card.inDeck = true
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadNewDeck() {
        emojiDeck += Card.emojiDeck()
    }
    
    func displayCard() {
        if let card = displayedCardView {
            view.addSubview(card)
            card.translatesAutoresizingMaskIntoConstraints = false
            _ = [
                card.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 8.0),
                card.bottomAnchor.constraint(equalTo: drawCardButton.topAnchor, constant: -8.0),
                card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
                card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0)
                ].map { $0.isActive = true }
            card.layer.cornerRadius = 20
            card.layer.borderWidth = 2
        }
    }
    
    func setUpEmptyStackView() {
        self.view.addSubview(emptyStackBox)
        emptyStackBox.translatesAutoresizingMaskIntoConstraints = false
        emptyStackBox.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.2)
        
        self.view.addSubview(emptyStackLabel)
        emptyStackLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStackLabel.text = "( Nothing on Stack )"
        emptyStackLabel.textColor = UIColor(white: 0.5, alpha: 0.5)
        
        let _ = [
            emptyStackBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStackBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStackBox.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            emptyStackBox.heightAnchor.constraint(equalTo: emptyStackBox.widthAnchor),
            emptyStackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ].map { $0.isActive = true }
    }

    func setUpButtons() {
        self.view.addSubview(drawCardButton)
        self.view.addSubview(removeRandomButton)
        self.view.addSubview(showStackButton)
        self.view.addSubview(removeAllButton)
        
        drawCardButton.translatesAutoresizingMaskIntoConstraints = false
        removeRandomButton.translatesAutoresizingMaskIntoConstraints = false
        showStackButton.translatesAutoresizingMaskIntoConstraints = false
        removeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        removeRandomButton.setTitle("Remove Random", for: .normal)
        removeAllButton.setTitle("Remove All", for: .normal)
        drawCardButton.setTitle("Draw Card", for: .normal)
        showStackButton.setTitle("Show Stack", for: .normal)
        
        let _ = [
            removeRandomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            removeRandomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            removeAllButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            removeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
            drawCardButton.bottomAnchor.constraint(equalTo: removeRandomButton.topAnchor, constant: -8.0),
            drawCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            showStackButton.bottomAnchor.constraint(equalTo: removeAllButton.topAnchor, constant: -8.0),
            showStackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0)
            ].map { $0.isActive = true }
        
        self.drawCardButton.addTarget(self, action: #selector(didPressDrawCard(sender:)), for: .touchUpInside)
        self.showStackButton.addTarget(self, action: #selector(didPressShowStack(sender:)), for: .touchUpInside)
        self.removeRandomButton.addTarget(self, action: #selector(didPressRemoveRandom(sender:)), for: .touchUpInside)
        self.removeAllButton.addTarget(self, action: #selector(didPressRemoveAll(sender:)), for: .touchUpInside)
    }
    
    func didPressDrawCard(sender: UIButton) {
        let remainingCards: [Card] = emojiDeck.filter { $0.inDeck == true }
        let newVC = EmojiCardViewController()
        if remainingCards.count > 0 {
            print("\(remainingCards.count - 1) cards remaining <<<")
            let nextCard = remainingCards[Int(arc4random_uniform(UInt32(remainingCards.count)))]
            nextCard.inDeck = false
            nextCard.count = cardCount + 1
            newVC.card = nextCard
            newVC.displayedCardView = EmojiCardView(value: nextCard.value, suit: nextCard.suit)
            newVC.firstTime = false
            newVC.emojiDeck = emojiDeck
            newVC.cardCount = cardCount + 1
            if let navVC = self.navigationController {
                navVC.pushViewController(newVC, animated: true)
            }
        } else {
            print("No more cards in deck.")
            let alertController = UIAlertController(title: "Deck Done", message: "Create a new deck and continue adding to the stack?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            let okayAction = UIAlertAction(title: "OK", style: .default) { (_) in
                self.loadNewDeck()
                print("40 cards remaining <<<")
            }
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func didPressRemoveRandom(sender: UIButton) {
        let remainingCards: [Card] = emojiDeck.filter { $0.inDeck == false }
        let randomCardToRemove = remainingCards[Int(arc4random_uniform(UInt32(remainingCards.count)))]
        randomCardToRemove.inDeck = true
        
        //remove VC that corresponds to that card.
        guard let vcs = navigationController?.viewControllers else { return }
        for i in 0..<vcs.count {
            if let emojiVcToRemove = vcs[i] as? EmojiCardViewController,
                let card = emojiVcToRemove.card, card.count == randomCardToRemove.count {
                self.navigationController?.viewControllers.remove(at: i)
            }
        }
        let alert = UIAlertController(title: title, message: "Random Card Removed: \(randomCardToRemove.name)", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    func didPressShowStack(sender: UIButton) {
        let stackTVC = EmojiStackTableViewController()
        stackTVC.emojiDeck = emojiDeck.filter { $0.inDeck == false }
        if let navVC = self.navigationController {
            navVC.pushViewController(stackTVC, animated: true)
        }
    }
    
    func didPressRemoveAll(sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
        _ = emojiDeck.map { $0.inDeck = true }
    }
    
}

