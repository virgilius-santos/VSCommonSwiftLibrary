//
//  VLogger.swift
//  VCore
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import Willow

public let logger = VLogger()

public class VLogger {
    lazy var willowLogger: Logger = buildDebugLogger(name: "Logger")

    public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        willowLogger.debugMessage(self.format(message: message, file: file, function: function, line: line))
    }

    public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        willowLogger.infoMessage(self.format(message: message, file: file, function: function, line: line))
    }

    public func event(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        willowLogger.eventMessage(self.format(message: message, file: file, function: function, line: line))
    }

    public func warn(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        willowLogger.warnMessage(self.format(message: message, file: file, function: function, line: line))
    }

    public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        willowLogger.errorMessage(self.format(message: message, file: file, function: function, line: line))
    }

    func format(message: String, file: String, function: String, line: Int) -> String {
        #if DEBUG /* I use os_log in production where line numbers and functions are discouraged */
            return "[\(sourceFileName(filePath: file)) \(function):\(line)] \(message)"
        #else
            return message
        #endif
    }

    func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }

    func buildDebugLogger(name: String) -> Logger {
        let logModifier = VLogModifier(name: name)

        // prints straight to the console
        let consoleWriter = ConsoleWriter(modifiers: [logModifier])

        // create a new logger with all levels which prints synchronously to the console
        return Logger(logLevels: [.all],
                      writers: [consoleWriter],
                      executionMethod: .synchronous(lock: NSRecursiveLock()))
    }
}
