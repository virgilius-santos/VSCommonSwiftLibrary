//
//  VLogger.swift
//  VCore
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import Willow

public let logger = VLogger.willowLogger

public struct VLogger {
    static let willowLogger: Logger = buildDebugLogger(name: "Logger")

    private static func buildDebugLogger(name: String) -> Logger {
        let logModifier = VLogModifier(name: name)

        // prints straight to the console
        let consoleWriter = ConsoleWriter(modifiers: [logModifier])

        // create a new logger with all levels which prints synchronously to the console
        return Logger(logLevels: [.all],
                      writers: [consoleWriter],
                      executionMethod: .synchronous(lock: NSRecursiveLock()))
    }
}
