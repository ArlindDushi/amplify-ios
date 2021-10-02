//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

extension AWSLocationGeoPluginConfiguration {
    enum Section {
        case plugin
        case maps
        case searchIndices

        var key: String {
            String(describing: self)
        }

        var item: String {
            if self == .searchIndices {
                return "search index"
            } else {
                return String(String(describing: self).dropLast())
            }
        }
    }
}
