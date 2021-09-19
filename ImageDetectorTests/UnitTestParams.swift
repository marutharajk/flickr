//
//  UnitTestParams.swift
//  ImageDetectorTests
//
//  Created by Marutharaj K on 17/09/21.
//

import Foundation

@testable import ImageDetector

/**
 UnitTestParams will configure all the input for unit test and expected result
 */
class UnitTestParams {
    /// Stub JSON file name
    enum StubJSONFileName: String {
        case feedsSuccess    = "FeedsSuccess"
        case feedsFailure    = "FeedsFailure"
    }
}
