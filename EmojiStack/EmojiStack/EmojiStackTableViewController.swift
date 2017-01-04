//
//  EmojiStackTableViewController.swift
//  EmojiStack
//
//  Created by Tom Seymour on 12/22/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class EmojiStackTableViewController: UITableViewController {
    
    var emojiDeck: [Card]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiDeck.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = emojiDeck.sorted { $0.count! > $1.count! }[indexPath.row].name
        return cell
    }
}
