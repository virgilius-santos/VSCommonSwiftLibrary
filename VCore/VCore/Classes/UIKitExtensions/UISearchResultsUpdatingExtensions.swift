//
//  UISearchResultsUpdatingExtensions.swift
//  VCore
//
//  Created by Virgilius Santos on 21/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

public extension UISearchResultsUpdating where Self: UIViewController {
    
    @discardableResult
    func addSearchBar(placeholder: String, scopeButtonTitles: [String]) -> UISearchController {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        let searchBar = search.searchBar
        searchBar.placeholder = placeholder
        searchBar.scopeButtonTitles = scopeButtonTitles
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        return search
    }
}
