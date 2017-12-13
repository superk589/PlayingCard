//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by zzk on 12/12/2017.
//  Copyright © 2017 zzk. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1
        behavior.resistance = 0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        
        // push towards center
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y < center.y :
                push.angle = (CGFloat.pi / 2).arc4random
            case let (x, y) where x > center.x && y < center.y :
                push.angle = CGFloat.pi - (CGFloat.pi / 2).arc4random
            case let (x, y) where x < center.x && y > center.y :
                push.angle = -(CGFloat.pi / 2).arc4random
            case let (x, y) where x > center.x && y > center.y :
                push.angle = CGFloat.pi + (CGFloat.pi / 2).arc4random
            default :
                push.angle = (2 * CGFloat.pi).arc4random
            }
        }
        
        push.magnitude = CGFloat(1) + CGFloat(2).arc4random
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
