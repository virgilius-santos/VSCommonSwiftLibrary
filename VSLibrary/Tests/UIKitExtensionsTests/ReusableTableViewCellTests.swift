
import UIKitExtensions
import XCTest

class ReusableTableViewCellTests: XCTestCase {
  func testTableViewCellRegisterCell() {
    let tableView = UITableViewMock()
    ReusableTableViewCellMock.registerForTableView(tableView)
    XCTAssertEqual(tableView.identifierSpy, ReusableTableViewCellMock.identifier)
    XCTAssert(tableView.cellClass == ReusableTableViewCellMock.self)
  }
  
  func testTableViewCellDequeueCell() {
    let tableView = UITableViewMock()
    _ = ReusableTableViewCellMock.dequeueCell(from: tableView, at: IndexPath(item: 9, section: 5))
    XCTAssertEqual(tableView.identifierSpy, ReusableTableViewCellMock.identifier)
    XCTAssertEqual(tableView.indexPath?.item, 9)
    XCTAssertEqual(tableView.indexPath?.section, 5)
  }
  
  func testCollectionViewCellRegisterCell() {
    let collectionView = UICollectionViewMock(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    ReusableCollectionViewCellMock.registerForTableView(collectionView)
    XCTAssertEqual(collectionView.identifierSpy, ReusableCollectionViewCellMock.identifier)
    XCTAssert(collectionView.cellClass == ReusableCollectionViewCellMock.self)
  }
  
  func testCollectionViewCellDequeueCell() {
    let collectionView = UICollectionViewMock(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    _ = ReusableCollectionViewCellMock.dequeueCell(from: collectionView, at: IndexPath(item: 9, section: 5))
    XCTAssertEqual(collectionView.identifierSpy, ReusableCollectionViewCellMock.identifier)
    XCTAssertEqual(collectionView.indexPath?.item, 9)
    XCTAssertEqual(collectionView.indexPath?.section, 5)
  }
}

private class ReusableTableViewCellMock: UITableViewCell, ReusableViewCell {}


private class ReusableCollectionViewCellMock: UICollectionViewCell, ReusableViewCell {}

private class UITableViewMock: UITableView {
  var cellClass: AnyClass?
  var identifierSpy: String?
  var indexPath: IndexPath?
  
  override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
    self.cellClass = cellClass
    self.identifierSpy = identifier
  }
  
  override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
    self.identifierSpy = identifier
    self.indexPath = indexPath
    return UITableViewCell()
  }
}

private class UICollectionViewMock: UICollectionView {
  var cellClass: AnyClass?
  var identifierSpy: String?
  var indexPath: IndexPath?
  
  override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
    self.cellClass = cellClass
    self.identifierSpy = identifier
  }
  
  override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
    self.identifierSpy = identifier
    self.indexPath = indexPath
    return UICollectionViewCell()
  }
}
