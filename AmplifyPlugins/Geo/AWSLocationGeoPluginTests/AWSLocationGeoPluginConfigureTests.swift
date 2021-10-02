//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
@testable import AWSLocationGeoPlugin
import XCTest

class AWSLocationGeoPluginConfigureTests: AWSLocationGeoPluginTestBase {
    // MARK: - Plugin Key test

    func testPluginKey() {
        let pluginKey = geoPlugin.key
        XCTAssertEqual(pluginKey, "awsLocationGeoPlugin")
    }

    // MARK: - Configuration tests

    func testConfigureSuccess() {
        let region = JSONValue(stringLiteral: testRegion)
        let map = JSONValue(stringLiteral: testMap)
        let style = JSONValue(stringLiteral: testStyle)
        let searchIndex = JSONValue(stringLiteral: testSearchIndex)
//
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.appIdConfigKey, appId),
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, region)
//        )
//
//        let regionConfiguration = JSONValue(dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, region))
//
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.autoFlushEventsIntervalKey, autoFlushInterval),
//            (AWSPinpointAnalyticsPluginConfiguration.trackAppSessionsKey, trackAppSession),
//            (AWSPinpointAnalyticsPluginConfiguration.autoSessionTrackingIntervalKey, autoSessionTrackingInterval)
//        )
//
//        do {
//            let analyticsPlugin = AWSPinpointAnalyticsPlugin()
//            try analyticsPlugin.configure(using: analyticsPluginConfig)
//
//            XCTAssertNotNil(analyticsPlugin.pinpoint)
//            XCTAssertNotNil(analyticsPlugin.authService)
//            XCTAssertNotNil(analyticsPlugin.autoFlushEventsTimer)
//            XCTAssertNotNil(analyticsPlugin.appSessionTracker)
//            XCTAssertNotNil(analyticsPlugin.globalProperties)
//            XCTAssertNotNil(analyticsPlugin.isEnabled)
//        } catch {
//            XCTFail("Failed to configure analytics plugin")
//        }
    }

    func testConfigureFailureForNilConfiguration() throws {
        let plugin = AWSLocationGeoPlugin()
        do {
            try plugin.configure(using: nil)
            XCTFail("Geo configuration should not succeed.")
        } catch {
            guard let pluginError = error as? PluginError,
                case .pluginConfigurationError = pluginError else {
                    XCTFail("Should throw invalidConfiguration exception. But received \(error) ")
                    return
            }
        }
    }
}
