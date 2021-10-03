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
        // MARK: - Maps Config
        let mapStyleJSON = JSONValue(stringLiteral: testStyle)
        let testMapJSON = JSONValue(stringLiteral: testMap)

        let mapStyleConfig = JSONValue(
            dictionaryLiteral: (AWSLocationGeoPluginConfiguration.Node.style.key, mapStyleJSON))

        let mapItemConfig = JSONValue(
            dictionaryLiteral: (testMap, mapStyleConfig))

        let mapsConfig = JSONValue(
            dictionaryLiteral: (AWSLocationGeoPluginConfiguration.Node.items.key, mapItemConfig),
                               (AWSLocationGeoPluginConfiguration.Node.default.key, testMapJSON))

        // MARK: - Search Config
        let searchIndexJSON = JSONValue(stringLiteral: testSearchIndex)
        let searchItemsArrayJSON = JSONValue(arrayLiteral: searchIndexJSON)

        let searchConfig = JSONValue(
            dictionaryLiteral: (AWSLocationGeoPluginConfiguration.Node.items.key, searchItemsArrayJSON),
                               (AWSLocationGeoPluginConfiguration.Node.default.key, searchIndexJSON))

        // MARK: - Plugin Config

        let regionJSON = JSONValue(stringLiteral: testRegion)

        let geoPluginConfig = JSONValue(
            dictionaryLiteral: (AWSLocationGeoPluginConfiguration.Node.region.key, regionJSON),
                               (AWSLocationGeoPluginConfiguration.Section.maps.key, mapsConfig),
                               (AWSLocationGeoPluginConfiguration.Section.searchIndices.key, searchConfig))

        geoPlugin.reset {}

        do {
            try geoPlugin.configure(using: geoPluginConfig)

            XCTAssertNotNil(geoPlugin.locationService)
            XCTAssertNotNil(geoPlugin.authService)
            XCTAssertNotNil(geoPlugin.pluginConfig)
        } catch {
            XCTFail("Failed to configure geo plugin with error: \(error)")
        }
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
