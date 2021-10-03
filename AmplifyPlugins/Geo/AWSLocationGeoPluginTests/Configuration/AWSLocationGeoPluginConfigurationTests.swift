//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import XCTest

@testable import AWSLocationGeoPlugin

class AWSLocationGeoPluginConfigurationTests: XCTestCase {

    func testConfigureSuccessAll() throws {
        do {
            let config = try AWSLocationGeoPluginConfiguration(config: GeoPluginTestConfig.geoPluginConfigJSON)
            XCTAssertNotNil(config)
            XCTAssertEqual(config.region, GeoPluginTestConfig.region)
            XCTAssertEqual(config.maps, GeoPluginTestConfig.maps)
            XCTAssertEqual(config.defaultMap, GeoPluginTestConfig.map)
            XCTAssertEqual(config.searchIndices, GeoPluginTestConfig.searchIndices)
            XCTAssertEqual(config.defaultSearchIndex, GeoPluginTestConfig.searchIndex)
        } catch {
            XCTFail("Failed to instantiate geo plugin configuration")
        }
    }

    func testConfigureSuccessEmpty() throws {
        let geoPluginConfigJSON = JSONValue(dictionaryLiteral:
            (AWSLocationGeoPluginConfiguration.Node.region.key, GeoPluginTestConfig.regionJSON))

        do {
            let config = try AWSLocationGeoPluginConfiguration(config: geoPluginConfigJSON)
            XCTAssertNotNil(config)
            XCTAssertEqual(config.region, GeoPluginTestConfig.region)
            XCTAssertTrue(config.maps.isEmpty)
            XCTAssertNil(config.defaultMap)
            XCTAssertTrue(config.searchIndices.isEmpty)
            XCTAssertNil(config.defaultSearchIndex)
        } catch {
            XCTFail("Failed to instantiate geo plugin configuration")
        }
    }

    func testConfigureSuccessOnlyMaps() throws {
        let geoPluginConfigJSON = JSONValue(dictionaryLiteral:
            (AWSLocationGeoPluginConfiguration.Node.region.key, GeoPluginTestConfig.regionJSON),
            (AWSLocationGeoPluginConfiguration.Section.maps.key, GeoPluginTestConfig.mapsConfigJSON))

        do {
            let config = try AWSLocationGeoPluginConfiguration(config: geoPluginConfigJSON)
            XCTAssertNotNil(config)
            XCTAssertEqual(config.region, GeoPluginTestConfig.region)
            XCTAssertEqual(config.maps, GeoPluginTestConfig.maps)
            XCTAssertEqual(config.defaultMap, GeoPluginTestConfig.map)
            XCTAssertTrue(config.searchIndices.isEmpty)
            XCTAssertNil(config.defaultSearchIndex)
        } catch {
            XCTFail("Failed to instantiate geo plugin configuration")
        }
    }

    func testConfigureSuccessOnlySearch() throws {
        let geoPluginConfigJSON = JSONValue(dictionaryLiteral:
            (AWSLocationGeoPluginConfiguration.Node.region.key, GeoPluginTestConfig.regionJSON),
            (AWSLocationGeoPluginConfiguration.Section.searchIndices.key, GeoPluginTestConfig.searchConfigJSON))

        do {
            let config = try AWSLocationGeoPluginConfiguration(config: geoPluginConfigJSON)
            XCTAssertNotNil(config)
            XCTAssertEqual(config.region, GeoPluginTestConfig.region)
            XCTAssertTrue(config.maps.isEmpty)
            XCTAssertNil(config.defaultMap)
            XCTAssertEqual(config.searchIndices, GeoPluginTestConfig.searchIndices)
            XCTAssertEqual(config.defaultSearchIndex, GeoPluginTestConfig.searchIndex)
        } catch {
            XCTFail("Failed to instantiate geo plugin configuration")
        }
    }

    func testConfigureThrowsErrorForMissingConfigurationObject() {
        let geoPluginConfig: Any? = nil

        XCTAssertThrowsError(try AWSLocationGeoPluginConfiguration(config: geoPluginConfig)) { error in
            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
                return
            }
            XCTAssertEqual(errorDescription,
                           GeoPluginConfigError.configurationInvalid(section: .plugin).errorDescription)
        }
    }

    func testConfigureThrowsErrorForInvalidConfigurationObject() {
        let geoPluginConfig = JSONValue(stringLiteral: "notADictionaryLiteral")

        XCTAssertThrowsError(try AWSLocationGeoPluginConfiguration(config: geoPluginConfig)) { error in
            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
                return
            }
            XCTAssertEqual(errorDescription,
                           GeoPluginConfigError.configurationInvalid(section: .plugin).errorDescription)
        }
    }
    
    func testConfigureThrowsErrorForInvalidMapsConfiguration() {
        let geoPluginConfig = JSONValue(stringLiteral: "notADictionaryLiteral")

        XCTAssertThrowsError(try AWSLocationGeoPluginConfiguration(config: geoPluginConfig)) { error in
            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
                return
            }
            XCTAssertEqual(errorDescription,
                           GeoPluginConfigError.configurationInvalid(section: .plugin).errorDescription)
        }
    }
//
//    func testConfigureThrowsErrorForInvalidConfigurationObject() {
//        let geoPluginConfig = JSONValue(stringLiteral: "notADictionaryLiteral")
//
//        XCTAssertThrowsError(try AWSLocationGeoPluginConfiguration(config: geoPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription,
//                           GeoPluginConfigError.configurationInvalid(section: .plugin).errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForInvalidConfigurationObject() {
//        let geoPluginConfig = JSONValue(stringLiteral: "notADictionaryLiteral")
//
//        XCTAssertThrowsError(try AWSLocationGeoPluginConfiguration(config: geoPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription,
//                           GeoPluginConfigError.configurationInvalid(section: .plugin).errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointAnalyticsConfiguration() {
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration))
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription,
//                           AnalyticsPluginErrorConstant.missingPinpointAnalyicsConfiguration.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointAnalyticsConfigurationObject() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(stringLiteral: "notDictionary")
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription,
//                           AnalyticsPluginErrorConstant.pinpointAnalyticsConfigurationExpected.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointAnalyticsAppId() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, region))
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.missingAppId.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForEmptyPinpointAnalyticsAppIdValue() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.appIdConfigKey, ""),
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, region)
//        )
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.emptyAppId.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForInvalidPinpointAnalyticsAppIdValue() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.appIdConfigKey, 1),
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, region)
//        )
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.invalidAppId.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointAnalyticsRegion() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.appIdConfigKey, appId))
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.missingRegion.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForEmptyPinpointAnalyticsRegionValue() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.appIdConfigKey, appId),
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, "")
//        )
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.emptyRegion.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForInvalidPinpointAnalyticsRegionValue() {
//        let pinpointAnalyticsPluginConfiguration = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.appIdConfigKey, appId),
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, "invalidRegion")
//        )
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.invalidRegion.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointTargetingConfiguration() {
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration))
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription,
//                           AnalyticsPluginErrorConstant.missingPinpointTargetingConfiguration.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointTargetingConfigurationObject() {
//        let regionConfiguration = JSONValue(stringLiteral: "notDictionary")
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription,
//                           AnalyticsPluginErrorConstant.pinpointTargetingConfigurationExpected.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForMissingPinpointTargetingRegion() {
//        let regionConfiguration = JSONValue(dictionaryLiteral:
//            ("MissingRegionKey", region))
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.missingRegion.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForEmptyPinpointTargetingRegionValue() {
//        let regionConfiguration = JSONValue(dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, ""))
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.emptyRegion.errorDescription)
//        }
//    }
//
//    func testConfigureThrowsErrorForInvalidPinpointTargetingRegionValue() {
//        let regionConfiguration = JSONValue(dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, "invalidRegion"))
//        let analyticsPluginConfig = JSONValue(
//            dictionaryLiteral:
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
//            (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration)
//        )
//
//        XCTAssertThrowsError(try AWSPinpointAnalyticsPluginConfiguration(analyticsPluginConfig)) { error in
//            guard case let PluginError.pluginConfigurationError(errorDescription, _, _) = error else {
//                XCTFail("Expected PluginError pluginConfigurationError, got: \(error)")
//                return
//            }
//            XCTAssertEqual(errorDescription, AnalyticsPluginErrorConstant.invalidRegion.errorDescription)
//        }
//    }
//
//    func testThrowsOnMissingConfig() throws {
//        let plugin = AWSPinpointAnalyticsPlugin()
//        try Amplify.add(plugin: plugin)
//
//        let categoryConfig = AnalyticsCategoryConfiguration(plugins: ["NonExistentPlugin": true])
//        let amplifyConfig = AmplifyConfiguration(analytics: categoryConfig)
//        do {
//            try Amplify.configure(amplifyConfig)
//            XCTFail("Should have thrown a pluginConfigurationError if not supplied with a plugin-specific config.")
//        } catch {
//            guard case PluginError.pluginConfigurationError = error else {
//                XCTFail("Should have thrown a pluginConfigurationError if not supplied with a plugin-specific config.")
//                return
//            }
//        }
//    }
}
