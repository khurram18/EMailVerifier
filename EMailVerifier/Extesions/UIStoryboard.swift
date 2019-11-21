//
//  UIStoryboard.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func instantiateUserVerifyViewController() -> UserVerifyViewController {
        instantiateViewController(identifier: "UserVerify") as! UserVerifyViewController
    }
}
