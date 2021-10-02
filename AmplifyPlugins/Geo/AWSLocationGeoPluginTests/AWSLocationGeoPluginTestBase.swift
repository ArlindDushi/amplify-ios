//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

@testable import Amplify
@testable import AmplifyTestCommon
@testable import AWSLocationGeoPlugin
import XCTest

class AWSLocationGeoPluginTestBase: XCTestCase {
    var geoPlugin: AWSLocationGeoPlugin!
    var mockAWSLocation: MockAWSLocation!
    var authService: MockAWSAuthService!

    let testRegion = "us-east-2"

    override func setUp() {
        geoPlugin = AWSLocationGeoPlugin()

        mockAWSLocation = MockAWSLocation()
        authService = MockAWSAuthService()

        geoPlugin.configure(locationService: mockAWSLocation,
                            authService: authService,
                            pluginConfig: <#T##AWSLocationGeoPluginConfiguration#>)

        Amplify.reset()
        let config = AmplifyConfiguration()
        do {
            try Amplify.configure(config)
        } catch {
            XCTFail("Error setting up Amplify: \(error)")
        }
    }

    override func tearDown() {
        Amplify.reset()
        geoPlugin.reset {}
    }
}
