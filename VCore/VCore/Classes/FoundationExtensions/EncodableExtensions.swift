//
//  EncodableExtensions.swift
//  VComponents
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

public extension Encodable {
    func data() throws -> Data {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(self)
        return data
    }
}
