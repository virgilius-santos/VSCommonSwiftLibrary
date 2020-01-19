//
//  VResponse.swift
//  VService
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import VCore

public struct VResponseData<DataReceived> {
    public let decode: (Data) throws -> (DataReceived)

    public init(decode: @escaping ((Data) throws -> (DataReceived))) {
        self.decode = decode
    }
}

public extension VResponseData where DataReceived: Decodable {
    init(type _: DataReceived.Type) {
        decode = { try DataReceived.decode(data: $0) }
    }

    init() {
        decode = { try DataReceived.decode(data: $0) }
    }
}
