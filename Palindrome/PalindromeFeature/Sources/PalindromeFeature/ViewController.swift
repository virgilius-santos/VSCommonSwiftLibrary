
import UIKit

public class PalindromeViewController: UIViewController {
  
  public let baseView = PalindromeView(frame: UIScreen.main.bounds)
  
  public let viewModel: PalindromeViewModel
  
  public init(viewModel: PalindromeViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func loadView() {
    view = baseView
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    baseView.tableView.delegate = self
    baseView.tableView.dataSource = self
    
    baseView.textField.delegate = self
    baseView.textField.placeholder = "Insira a palavra e descubra"
    
    baseView.titleLabel.text = "É palíndromo?"
    baseView.subtitleLabel.text = "Palavras Registradas"
    
    baseView.saveButton.setTitle("Salvar", for: .normal)
    baseView.saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    
    hideKeyboardWhenTappedAround()
    
    viewModel.isPalindrome.bind(key: identifier) { [baseView] isPalidrome in
      baseView.imageView.isHidden = !isPalidrome
    }
    
    viewModel.showError.bind(key: identifier) { [weak self] in
      let vc = UIAlertController(title: "Atenção", message: "Palindromo inválido!", preferredStyle: .alert)
      vc.addAction(.init(title: "Ok", style: .default))
      self?.present(vc, animated: true, completion: nil)
    }
  }
  
  @objc private func saveAction() {
    viewModel.saveWord { [baseView] in
      baseView.textField.text = String()
      baseView.tableView.reloadData()
    }
  }
  
  deinit {
    viewModel.isPalindrome.removeBind(key: identifier)
  }
}

extension PalindromeViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  
  public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [viewModel] (action, indexPath) in
      viewModel.deleteWord(indexPath.row) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
      }
    }
    
    return [deleteAction]
  }
}

extension PalindromeViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfWords()
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = viewModel.wordFor(indexPath.row)
    return cell
  }
}

extension PalindromeViewController: UITextFieldDelegate {
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if (string == "\n") {
      textField.resignFirstResponder()
    }
    return true
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    viewModel.isPalindrome.value = false
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    viewModel.newWord(textField.text)
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
