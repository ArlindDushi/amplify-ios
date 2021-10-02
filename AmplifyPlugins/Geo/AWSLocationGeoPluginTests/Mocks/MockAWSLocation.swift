//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSLocation
import Foundation
import XCTest

@testable import AWSLocationGeoPlugin

public class MockAWSLocation: AWSLocationBehavior {

    // MARK: - Method call counts for AWSLocation
    var getEscapeHatchCalled = 0
    var searchPlaceIndexForTextCalled = 0
    var searchPlaceIndexForPositionCalled = 0

    // MARK: - Method arguments for AWSLocation
    var searchPlaceIndexForTextRequest: AWSLocationSearchPlaceIndexForTextRequest?
    var searchPlaceIndexForPositionRequest: AWSLocationSearchPlaceIndexForPositionRequest?

    public init() {}

    public func getEscapeHatch() -> AWSLocation {
        getEscapeHatchCalled += 1
        return AWSLocation()
    }
}

extension MockAWSLocation {
    public func verifyGetEscapeHatch() {
        XCTAssertEqual(getEscapeHatchCalled, 1)
    }

    public func verifySearchPlaceIndexForText(_ request: AWSLocationSearchPlaceIndexForTextRequest) {
        XCTAssertEqual(searchPlaceIndexForTextCalled, 1)
        XCTAssertEqual(searchPlaceIndexForTextRequest, request)
    }

    public func verifySearchPlaceIndexForPosition(_ request: AWSLocationSearchPlaceIndexForPositionRequest) {
        XCTAssertEqual(searchPlaceIndexForPositionCalled, 1)
        XCTAssertEqual(searchPlaceIndexForPositionRequest, request)
    }
}

