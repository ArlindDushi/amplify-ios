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
    var pluginConfig: AWSLocationGeoPluginConfiguration!
    var emptyPluginConfig: AWSLocationGeoPluginConfiguration!

    override func setUp() {
        // Map Test Configuration
        let testRegion = "us-east-2"
        let testMap = "testMap"
        let testStyle = "VectorEsriStreets"
        let testURLString = "https://maps.geo.\(testRegion).amazonaws.com/maps/v0/maps/\(testMap)/style-descriptor"
        let testURL = URL(string: testURLString)!
        let testMapStyle = Geo.MapStyle(mapName: testMap, style: testStyle, styleURL: testURL)

        // Search Test Configuration
        let testSearchIndex = "testSearchIndex"

        pluginConfig = AWSLocationGeoPluginConfiguration(region: testRegion.aws_regionTypeValue(),
                                                         regionName: testRegion,
                                                         defaultMap: testMap,
                                                         maps: [testMap: testMapStyle],
                                                         defaultSearchIndex: testSearchIndex,
                                                         searchIndices: [testSearchIndex])

        emptyPluginConfig = AWSLocationGeoPluginConfiguration(region: testRegion.aws_regionTypeValue(),
                                                              regionName: testRegion,
                                                              defaultMap: nil,
                                                              maps: [:],
                                                              defaultSearchIndex: nil,
                                                              searchIndices: [])

        geoPlugin = AWSLocationGeoPlugin()
        geoPlugin.locationService = MockAWSLocation()
        geoPlugin.authService = MockAWSAuthService()
        geoPlugin.pluginConfig = pluginConfig

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
