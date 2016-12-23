//
//  EmojiCardView.swift
//  EmojiStack
//
//  Created by Tom Seymour on 12/20/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class EmojiCardView: UIView {
    
    var suit: String!
    var value: Int!
    
    private var topLeftLabel: UILabel = UILabel()
    private var bottomRightLabel: UILabel = UILabel()
    private var centerLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(value: Int, suit: String) {
        self.init(frame: CGRect.zero)
        self.value = value
        self.suit = suit
        layoutnumberLabels()
        layoutCenterLabel()
        self.backgroundColor = UIColor(white: 0.93, alpha: 1.0)
    }
    
    private func layoutnumberLabels() {
        self.addSubview(topLeftLabel)
        self.addSubview(bottomRightLabel)
        self.topLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bottomRightLabel.translatesAutoresizingMaskIntoConstraints = false
        topLeftLabel.font = UIFont(name: topLeftLabel.font.fontName, size: 26)
        bottomRightLabel.font = UIFont(name: bottomRightLabel.font.fontName, size: 26)
        if let v = value, let s = suit {
            topLeftLabel.text = "\(v) \(s)"
            bottomRightLabel.text = "\(v) \(s)"
        }
        bottomRightLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        _ = [
            topLeftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            topLeftLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
            bottomRightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0),
            bottomRightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
            ].map { $0.isActive = true }
    }
    
    private func layoutCenterLabel() {
        self.addSubview(centerLabel)
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        _ = [
            centerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ].map { $0.isActive = true }
        centerLabel.textAlignment = .center
        centerLabel.numberOfLines = 0
        centerLabel.backgroundColor = .lightGray
        centerLabel.layer.borderWidth = 1.0
        centerLabel.font = UIFont(name: centerLabel.font.fontName, size: 40)
        if let s = self.suit {
            switch self.value {
            case 1:
                centerLabel.text = "\(s)"
            case 2:
                centerLabel.text = "\(s)\n\(s)"
            case 3:
                centerLabel.text = "\(s)\n\(s)\n\(s)"
            case 4:
                centerLabel.text = "\(s)  \(s)\n\(s)  \(s)"
            case 5:
                centerLabel.text = "\(s)  \(s)\n\(s)\n\(s)  \(s)"
            case 6:
                centerLabel.text = "\(s)  \(s)\n\(s)  \(s)\n\(s)  \(s)"
            case 7:
                centerLabel.text = "\(s)  \(s)\n\(s)\n\(s)  \(s)\n\(s)  \(s)"
            case 8:
                centerLabel.text = "\(s)  \(s)\n\(s)\n\(s)  \(s)\n\(s)\n\(s)  \(s)"
            case 9:
                centerLabel.text = "\(s)  \(s)\n\(s)  \(s)\n\(s)\n\(s)  \(s)\n\(s)  \(s)"
            case 10:
                centerLabel.text = "\(s)  \(s)\n\(s)\n\(s)  \(s)\n\(s)  \(s)\n\(s)\n\(s)  \(s)"
            default:
                break
            }
        }
    }
}
