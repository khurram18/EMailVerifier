//
//  UINavigationController.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 22/11/2019.
//

import UIKit

extension UINavigationController {
    func removeViewController(at index: Int, animated: Bool) {
        var controllers = viewControllers
        controllers.remove(at: index)
        setViewControllers(controllers, animated: animated)
    }
}
