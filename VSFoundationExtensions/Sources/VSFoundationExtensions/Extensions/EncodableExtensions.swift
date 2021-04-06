
import Foundation
import os.log

public extension Encodable {
  func data(
    jsonEncoder: JSONEncoder = .init(),
    dso: UnsafeRawPointer = #dsohandle,
    file: String = #fileID,
    function: String = #function,
    line: Int = #line,
    log: OSLog = .default
  ) throws -> Data {
    try logIfError(
      dso: dso,
      log: log,
      file: file,
      function: function,
      line: line,
      try jsonEncoder.encode(self)
    )
  }
}
