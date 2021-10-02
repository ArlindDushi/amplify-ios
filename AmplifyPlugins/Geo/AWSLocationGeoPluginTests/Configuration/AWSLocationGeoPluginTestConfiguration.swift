//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class AWSLocationGeoPluginTestConfiguration {
    let testAppId = "testAppId"
    let appId: JSONValue = "testAppId"
    let testRegion = "us-east-1"
    let region: JSONValue = "us-east-2"
    let testAutoFlushInterval = 300
    let autoFlushInterval: JSONValue = 300
    let testTrackAppSession = false
    let trackAppSession: JSONValue = false
    let testAutoSessionTrackingInterval = 100
    let autoSessionTrackingInterval: JSONValue = 100
    let mapStyle = JSONValue(dictionaryLiteral: ("style", "VectorEsriStreets"))
    let mapItem = JSONValue(dictionaryLiteral: ("TestMap", mapStyle))
    let itesm = JSONValue
                            
    let regionConfiguration = JSONValue(dictionaryLiteral:
        (AWSPinpointAnalyticsPluginConfiguration.regionConfigKey, "us-east-1"))
    let analyticsPluginConfig = JSONValue(
        dictionaryLiteral:
        (AWSPinpointAnalyticsPluginConfiguration.pinpointAnalyticsConfigKey, pinpointAnalyticsPluginConfiguration),
        (AWSPinpointAnalyticsPluginConfiguration.pinpointTargetingConfigKey, regionConfiguration),
        (AWSPinpointAnalyticsPluginConfiguration.autoFlushEventsIntervalKey, autoFlushInterval)
    )
