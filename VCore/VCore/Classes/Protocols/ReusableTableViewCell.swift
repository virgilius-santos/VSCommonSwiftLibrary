//
//  UITableViewCellExtensions.swift
//  VCore
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

public protocol ReusableTableViewCell {}

public extension ReusableTableViewCell where Self: UITableViewCell {
    static func cellIdentifier() -> String {
        String(describing: Self.self)
    }

    static func registerForTableView(_ tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: cellIdentifier())
    }

    static func dequeueCell(from tableView: UITableView, at indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(),
                                                 for: indexPath)
        return (cell as? Self) ?? Self()
    }
}

public extension ReusableTableViewCell where Self: UICollectionViewCell {
    static func cellIdentifier() -> String {
        String(describing: Self.self)
    }

    static func registerForTableView(_ collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: cellIdentifier())
    }

    static func dequeueCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier(),
                                                      for: indexPath)
        return (cell as? Self) ?? Self()
    }
}
