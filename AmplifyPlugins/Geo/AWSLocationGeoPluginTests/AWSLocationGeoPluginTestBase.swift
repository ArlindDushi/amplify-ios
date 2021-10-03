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
        let region = GeoPluginTestConfig.region
        let map = GeoPluginTestConfig.map
        let style = GeoPluginTestConfig.style
        let searchIndex = GeoPluginTestConfig.searchIndex
        let url = URL(string: "https://maps.geo.\(region).amazonaws.com/maps/v0/maps/\(map)/style-descriptor")!
        let mapStyle = Geo.MapStyle(mapName: map, style: style, styleURL: url)

        pluginConfig = AWSLocationGeoPluginConfiguration(region: region.aws_regionTypeValue(),
                                                         regionName: region,
                                                         defaultMap: map,
                                                         maps: [map: mapStyle],
                                                         defaultSearchIndex: searchIndex,
                                                         searchIndices: [searchIndex])

        emptyPluginConfig = AWSLocationGeoPluginConfiguration(region: region.aws_regionTypeValue(),
                                                              regionName: region,
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
