
import UIKit
import FoundationExtensions

public protocol ReusableViewCell {}

public extension ReusableViewCell where Self: UITableViewCell {
  
  static func registerForTableView(_ tableView: UITableView) {
    tableView.register(Self.self, forCellReuseIdentifier: identifier)
  }
  
  static func dequeueCell(from tableView: UITableView, at indexPath: IndexPath) -> Self {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    return (cell as? Self) ?? Self()
  }
}

public extension ReusableViewCell where Self: UICollectionViewCell {
  
  static func registerForTableView(_ collectionView: UICollectionView) {
    collectionView.register(Self.self, forCellWithReuseIdentifier: identifier)
  }
  
  static func dequeueCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    return (cell as? Self) ?? Self()
  }
}
