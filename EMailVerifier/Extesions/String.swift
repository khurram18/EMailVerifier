//
//  String.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import Foundation

extension String {
    static let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    var isValidEmail: Bool {
        return String.emailPredicate.evaluate(with: self)
    }
    var isValidPassword: Bool {
        return count >= 8
    }
}
