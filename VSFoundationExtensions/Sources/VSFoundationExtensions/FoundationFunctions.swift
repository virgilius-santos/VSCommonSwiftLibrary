
import Foundation
import os.log
import VSFunctionsFeature

public func logIfError<B>(
  dso: UnsafeRawPointer = #dsohandle,
  log: OSLog = .default,
  file: String = #fileID,
  function: String = #function,
  line: Int = #line,
  _ f: @autoclosure () throws -> B
) throws -> B {
  do {
    return try f()
  } catch {
    os_log(.error, dso: dso, log: log, "%s:%s:%d: Error: %@", file, function, line, String(describing: error))
    throw error
  }
}
