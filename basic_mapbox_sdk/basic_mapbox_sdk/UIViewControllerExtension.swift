//
//  UIViewControllerExtension.swift
//  basic_mapbox_sdk
//
//  Created by Rajen Dey on 10/21/21.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        viewWillDisappear(false)
        view.removeFromSuperview()
        removeFromParent()
    }
}
