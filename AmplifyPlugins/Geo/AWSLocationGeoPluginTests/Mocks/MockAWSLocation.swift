//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSPinpoint
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

    public func getEscapeHatch() -> AWSPinpoint {
        getEscapeHatchCalled += 1
        return AWSLocation
    }
}

extension MockAWSLocation {
    public func verifyGetEscapeHatch() {
        XCTAssertEqual(getEscapeHatchCalled, 1)
    }

    public func verifyRemoveAttribute(forKey theKey: String) {
        XCTAssertEqual(removeAttributeCalled, 1)
        XCTAssertEqual(removeAttributeKey, theKey)
    }

    public func verifyAddMetric(_ theValue: NSNumber, forKey theKey: String) {
        XCTAssertEqual(addMetricCalled, 1)
        XCTAssertEqual(addMetricValue, theValue)
        XCTAssertEqual(addMetricKey, theKey)
    }

    public func verifyRemoveMetric(forKey theKey: String) {
        XCTAssertEqual(removeMetricCalled, 1)
        XCTAssertEqual(removeMetricKey, theKey)
    }
}

