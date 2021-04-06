
import Foundation
import os.log
import VSFunctionsFeature

public extension Decodable {
  static func decode(
    jsonDecoder: JSONDecoder = .init(),
    data: Data,
    dso: UnsafeRawPointer = #dsohandle,
    file: String = #fileID,
    function: String = #function,
    line: Int = #line,
    log: OSLog = .default
  ) throws -> Self {
    try logIfError(
      dso: dso,
      log: log,
      file: file,
      function: function,
      line: line,
      try jsonDecoder.decode(Self.self, from: data)
    )
  }
}
