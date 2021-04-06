
import UIKit
import VSFunctionsFeature

public extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard)
    )
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
   @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @discardableResult
  func addSearchBar(placeholder: String, scopeButtonTitles: [String]) -> UISearchController {
    let search = UISearchController(searchResultsController: nil)
    
    search.obscuresBackgroundDuringPresentation = false
    
    configSearchBar(placeholder, scopeButtonTitles)(search.searchBar)
    configNavigationItem(search)(navigationItem)
    
    return search
  }
}

func configSearchBar(_ placeholder: String, _ scopeButtonTitles: [String]) -> (_ searchBar: UISearchBar) -> Void {
  {
    $0.placeholder = placeholder
    $0.scopeButtonTitles = scopeButtonTitles
  }
}

func configNavigationItem(_ search: UISearchController) -> (_ navigationItem: UINavigationItem) -> Void {
  {
    $0.searchController = search
    $0.hidesSearchBarWhenScrolling = false
  }
}
