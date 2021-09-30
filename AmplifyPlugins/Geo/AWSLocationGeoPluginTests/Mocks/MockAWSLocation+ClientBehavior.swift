//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSPinpoint
@testable import AWSPinpointAnalyticsPlugin
import Foundation
@testable import AWSLocation

extension MockAWSLocation: AWSLocationBehavior {
    
    func searchPlaceIndex(forText: AWSLocationSearchPlaceIndexForTextRequest,
                          completionHandler: ((AWSLocationSearchPlaceIndexForTextResponse?,
                                               Error?) -> Void)?) {
        searchPlaceIndexForTextCalled += 1
        completionHandler(AWSLocationSearchForTextResult())
    }

    func searchPlaceIndex(forPosition: AWSLocationSearchPlaceIndexForPositionRequest,
                          completionHandler: ((AWSLocationSearchPlaceIndexForPositionResponse?,
                                               Error?) -> Void)?) {
        searchPlaceIndexForPositionCalled += 1
        completionHandler(AWSLocationSearchForTextResult())
    }
}
