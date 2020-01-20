//
//  VCoreTests.swift
//  VCoreTests
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

@testable import VCore
import XCTest

class ReusableTableViewCellTests: XCTestCase {
    func testTableViewCellIdentifier() {
        XCTAssertEqual(ReusableTableViewCellMock.cellIdentifier(), "ReusableTableViewCellMock")
    }

    func testTableViewCellRegisterCell() {
        let tableView = UITableViewMock()
        ReusableTableViewCellMock.registerForTableView(tableView)
        XCTAssertEqual(tableView.identifier, "ReusableTableViewCellMock")
        XCTAssert(tableView.cellClass == ReusableTableViewCellMock.self)
    }

    func testTableViewCellDequeueCell() {
        let tableView = UITableViewMock()
        _ = ReusableTableViewCellMock.dequeueCell(from: tableView, at: IndexPath(item: 9, section: 5))
        XCTAssertEqual(tableView.identifier, "ReusableTableViewCellMock")
        XCTAssertEqual(tableView.indexPath?.item, 9)
        XCTAssertEqual(tableView.indexPath?.section, 5)
    }
    
    func testCollectionViewCellIdentifier() {
        XCTAssertEqual(ReusableCollectionViewCellMock.cellIdentifier(), "ReusableCollectionViewCellMock")
    }

    func testCollectionViewCellRegisterCell() {
        let collectionView = UICollectionViewMock(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        ReusableCollectionViewCellMock.registerForTableView(collectionView)
        XCTAssertEqual(collectionView.identifier, "ReusableCollectionViewCellMock")
        XCTAssert(collectionView.cellClass == ReusableCollectionViewCellMock.self)
    }

    func testCollectionViewCellDequeueCell() {
        let collectionView = UICollectionViewMock(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        _ = ReusableCollectionViewCellMock.dequeueCell(from: collectionView, at: IndexPath(item: 9, section: 5))
        XCTAssertEqual(collectionView.identifier, "ReusableCollectionViewCellMock")
        XCTAssertEqual(collectionView.indexPath?.item, 9)
        XCTAssertEqual(collectionView.indexPath?.section, 5)
    }
}

private class ReusableTableViewCellMock: UITableViewCell, ReusableViewCell {}


private class ReusableCollectionViewCellMock: UICollectionViewCell, ReusableViewCell {}

private class UITableViewMock: UITableView {
    var cellClass: AnyClass?
    var identifier: String?
    var indexPath: IndexPath?

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        self.cellClass = cellClass
        self.identifier = identifier
    }

    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        self.identifier = identifier
        self.indexPath = indexPath
        return UITableViewCell()
    }
}

private class UICollectionViewMock: UICollectionView {
    var cellClass: AnyClass?
    var identifier: String?
    var indexPath: IndexPath?

    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        self.cellClass = cellClass
        self.identifier = identifier
    }

    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        self.identifier = identifier
        self.indexPath = indexPath
        return UICollectionViewCell()
    }
}
