//
//  DictionaryExtensions.swift
//  VCore
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

public extension Dictionary where Value == Any {
    
    func data(options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions.prettyPrinted) throws -> Data {
        return try JSONSerialization
            .data(withJSONObject: self, options: options)
    }
}
