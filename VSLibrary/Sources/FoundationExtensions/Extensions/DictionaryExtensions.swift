
import Foundation
import os.log

public extension Dictionary where Value == Any {
  func data(
    options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions.prettyPrinted,
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
      try JSONSerialization.data(withJSONObject: self, options: options)
    )
  }
}
