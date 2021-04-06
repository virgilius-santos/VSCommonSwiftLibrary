//font: https://www.swiftbysundell.com/articles/caching-in-swift/

import Foundation
import FoundationExtensions

public final class Cache<Key: Hashable, Value> {
  private let wrapped = NSCache<WrappedKey, Entry>()
  private let dateProvider: () -> Date
  private let entryLifetime: TimeInterval
  private let keyTracker = KeyTracker()
  
  public init(
    dateProvider: @escaping () -> Date = Date.init,
    entryLifetime: TimeInterval = 24 * 60 * 60, // 24 horas,
    maximumEntryCount: Int = 500
  ) {
    self.dateProvider = dateProvider
    self.entryLifetime = entryLifetime
    wrapped.countLimit = maximumEntryCount
    wrapped.delegate = keyTracker
  }
  
  public func insert(_ value: Value, forKey key: Key) {
    let date = dateProvider().addingTimeInterval(entryLifetime)
    let entry = Entry(key: key, value: value, expirationDate: date)
    wrapped.setObject(entry, forKey: WrappedKey(key))
    keyTracker.keys.insert(key)
  }
  
  public func value(forKey key: Key) -> Value? {
    return entry(forKey: key)?.value
  }
  
  public func removeValue(forKey key: Key) {
    wrapped.removeObject(forKey: WrappedKey(key))
  }
}

private extension Cache {
  func entry(forKey key: Key) -> Entry? {
    guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
      return nil
    }
    
    guard dateProvider() < entry.expirationDate else {
      removeValue(forKey: key)
      return nil
    }
    
    return entry
  }
  
  func insert(_ entry: Entry) {
    wrapped.setObject(entry, forKey: WrappedKey(entry.key))
    keyTracker.keys.insert(entry.key)
  }
}

extension Cache: Codable where Key: Codable, Value: Codable {
  public convenience init(from decoder: Decoder) throws {
    self.init()
    
    let container = try decoder.singleValueContainer()
    let entries = try container.decode([Entry].self)
    entries.forEach(insert)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(keyTracker.keys.compactMap(entry))
  }
}

public extension Cache where Key: Codable, Value: Codable {
  
  static func readFromDisk(
    withName name: String,
    using fileManager: FileManager = .default
  ) throws -> Self {
    let folderURLs = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    )
    
    let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
    let data = try logIfError(try Data(contentsOf: fileURL))
    return try Self.decode(data: data)
  }
  
  func saveToDisk(
    withName name: String,
    using fileManager: FileManager = .default
  ) throws {
    let folderURLs = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    )
    
    let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
    let data = try self.data()
    try data.write(to: fileURL)
  }
}
