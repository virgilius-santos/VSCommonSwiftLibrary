
import Foundation

extension Cache {
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()

        func cache(
            _ cache: NSCache<AnyObject, AnyObject>,
            willEvictObject object: Any
        ) {
            guard let entry = object as? Entry else { return }
            keys.remove(entry.key)
        }
    }
}

//extension Cache {
//    func entry(forKey key: Key) -> Entry? {
//        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
//            return nil
//        }
//
//        guard dateProvider() < entry.expirationDate else {
//            removeValue(forKey: key)
//            return nil
//        }
//
//        return entry
//    }
//
//    func insert(_ entry: Entry) {
//        wrapped.setObject(entry, forKey: WrappedKey(entry.key))
//        keyTracker.keys.insert(entry.key)
//    }
//}
