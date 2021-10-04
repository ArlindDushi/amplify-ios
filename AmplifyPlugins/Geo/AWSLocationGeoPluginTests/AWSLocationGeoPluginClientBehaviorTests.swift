//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import AWSLocation
@testable import AWSLocationGeoPlugin
import CwlPreconditionTesting
import XCTest

class AWSLocationGeoPluginClientBehaviorTests: AWSLocationGeoPluginTestBase {
    // MARK: - Search
    func testSearchForText() {
        let text = "starbucks"
        let expResult = expectation(description: "Receive result")
        geoPlugin.search(for: text) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            case .success:
                let request = AWSLocationSearchPlaceIndexForTextRequest()!
                request.text = text
                self?.mockLocation.verifySearchPlaceIndexForText(request)
                expResult.fulfill()
            }
        }
        waitForExpectations(timeout: GeoPluginTestConfig.timeout)
    }

    func testSearchForTextWithOptions() {
        let text = "starbucks"
        let coords = Geo.Coordinates(latitude: 39.5186, longitude: -104.7614)
        let countries: [Geo.Country] = [.USA, .CAN]
        let maxResults = 5
        let searchIndex = GeoPluginTestConfig.searchIndex
        let expResult = expectation(description: "Receive result")
        geoPlugin.search(for: text,
                         area: .near(coords),
                         countries: countries,
                         maxResults: maxResults,
                         placeIndexName: searchIndex) { [weak self] result in

            switch result {
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            case .success:
                let request = AWSLocationSearchPlaceIndexForTextRequest()!
                request.text = text
                request.biasPosition = [coords.longitude as NSNumber, coords.latitude as NSNumber]
                request.filterCountries = countries.map { String(describing: $0) }
                request.maxResults = maxResults as NSNumber
                request.indexName = searchIndex
                self?.mockLocation.verifySearchPlaceIndexForText(request)
                expResult.fulfill()
            }
        }
        waitForExpectations(timeout: GeoPluginTestConfig.timeout)
    }

    func testSearchForTextWithoutConfigFails() {
        geoPlugin.pluginConfig = emptyPluginConfig
        let text = "starbucks"

        var reachedPoint1 = false
        var reachedPoint2 = false
        let missingConfigAssertion = CwlPreconditionTesting.catchBadInstruction {
            reachedPoint1 = true
            self.geoPlugin.search(for: text) { _ in }
            reachedPoint2 = true
        }
        XCTAssertNotNil(missingConfigAssertion)
        XCTAssertTrue(reachedPoint1)
        XCTAssertFalse(reachedPoint2)
    }

    func testSearchForCoordinates() {
        let coords = Geo.Coordinates(latitude: 39.5186, longitude: -104.7614)
        let expResult = expectation(description: "Receive result")
        geoPlugin.search(for: coords) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            case .success:
                let request = AWSLocationSearchPlaceIndexForPositionRequest()!
                request.position = [coords.longitude as NSNumber, coords.latitude as NSNumber]
                self?.mockLocation.verifySearchPlaceIndexForPosition(request)
                expResult.fulfill()
            }
        }
        waitForExpectations(timeout: GeoPluginTestConfig.timeout)
    }

    func testSearchForCoordinatesWithOptions() {
        let coords = Geo.Coordinates(latitude: 39.5186, longitude: -104.7614)
        let maxResults = 5
        let searchIndex = GeoPluginTestConfig.searchIndex
        let expResult = expectation(description: "Receive result")
        geoPlugin.search(for: coords,
                         maxResults: maxResults,
                         placeIndexName: searchIndex) { [weak self] result in

            switch result {
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            case .success:
                let request = AWSLocationSearchPlaceIndexForPositionRequest()!
                request.position = [coords.longitude as NSNumber, coords.latitude as NSNumber]
                request.maxResults = maxResults as NSNumber
                request.indexName = searchIndex
                self?.mockLocation.verifySearchPlaceIndexForPosition(request)
                expResult.fulfill()
            }
        }
        waitForExpectations(timeout: GeoPluginTestConfig.timeout)
    }

    func testSearchForCoordinatesWithoutConfigFails() {
        geoPlugin.pluginConfig = emptyPluginConfig
        let coords = Geo.Coordinates(latitude: 39.5186, longitude: -104.7614)

        var reachedPoint1 = false
        var reachedPoint2 = false
        let missingConfigAssertion = CwlPreconditionTesting.catchBadInstruction {
            reachedPoint1 = true
            self.geoPlugin.search(for: coords) { _ in }
            reachedPoint2 = true
        }
        XCTAssertNotNil(missingConfigAssertion)
        XCTAssertTrue(reachedPoint1)
        XCTAssertFalse(reachedPoint2)
    }

    // MARK: - Maps
    func testGetAvailableMaps() {
        let maps = geoPlugin.getAvailableMaps()

        XCTAssertEqual(maps.count, GeoPluginTestConfig.maps.count)
        for map in maps {
            XCTAssertEqual(GeoPluginTestConfig.maps[map.mapName], map)
        }
    }

    func testGetAvailableMapsWithoutConfigFails() {
        geoPlugin.pluginConfig = emptyPluginConfig

        var reachedPoint1 = false
        var reachedPoint2 = false
        let missingConfigAssertion = CwlPreconditionTesting.catchBadInstruction {
            reachedPoint1 = true
            _ = self.geoPlugin.getAvailableMaps()
            reachedPoint2 = true
        }
        XCTAssertNotNil(missingConfigAssertion)
        XCTAssertTrue(reachedPoint1)
        XCTAssertFalse(reachedPoint2)
    }

    func testGetDefaultMap() {
        let map = geoPlugin.getDefaultMap()

        XCTAssertEqual(map, GeoPluginTestConfig.mapStyle)
    }

    func testGetDefaultMapWithoutConfigFails() {
        geoPlugin.pluginConfig = emptyPluginConfig

        var reachedPoint1 = false
        var reachedPoint2 = false
        let missingConfigAssertion = CwlPreconditionTesting.catchBadInstruction {
            reachedPoint1 = true
            _ = self.geoPlugin.getDefaultMap()
            reachedPoint2 = true
        }
        XCTAssertNotNil(missingConfigAssertion)
        XCTAssertTrue(reachedPoint1)
        XCTAssertFalse(reachedPoint2)
    }
}
