//
//  DecodableExtensions.swift
//  VCore
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

public extension Decodable {
    
    static func decode(data: Data) throws -> Self {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Self.self, from: data)
    }
}
