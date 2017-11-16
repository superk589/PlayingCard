//
//  ViewController.swift
//  PlayingCard
//
//  Created by zzk on 16/11/2017.
//  Copyright © 2017 zzk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }

}

