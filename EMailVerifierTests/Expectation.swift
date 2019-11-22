//
//  Expectation.swift
//  EMailVerifierTests
//
//  Created by Khurram Shehzad on 22/11/2019.
//

import Foundation
import XCTest

extension XCTestCase {
    func defaultExpectation(_ functionName: String = #function) -> XCTestExpectation {
        return expectation(description: functionName)
    }
}
