import XCTest
import Functions

final class FunctionsFeatureTests: XCTestCase {
  func test_pointFree_0001() {
    XCTAssertEqual(2 |> incr, 3)
    XCTAssertEqual(2 |> incr |> square, 9)
    
    let composeFunctions = incr >>> square
    XCTAssertEqual(2 |> incr >>> square, 9)
    XCTAssertEqual(2 |> composeFunctions >>> String.init, "9")
    
    XCTAssertEqual(
      [1, 2, 3].map(incr(_:) >>> square(_:) >>> String.init),
      ["4", "9", "16"]
    )
  }
  
  func test_pointFree_0002() {
    XCTAssertEqual(2 |> compute, 5)
    XCTAssertEqual(3 |> compute, 10)
    XCTAssertEqual(4 |> compute, 17)
    
    printed = ""
    XCTAssertEqual(
      [1,2,3].map(computeWithEffect(_:)).map(computeWithEffect(_:)),
      [5, 26, 101]
    )
    let result1 = printed
    printed = ""
    XCTAssertEqual(
      [1,2,3].map(computeWithEffect(_:) >=> computeWithEffect(_:)),
      [5, 26, 101]
    )
    let result2 = printed
    printed = ""
    XCTAssertNotEqual(result1, result2)
    
    XCTAssertEqual(
      [1,2,3].map(computeAndPrint(_:)).map(\.0),
      [2, 5, 10]
    )
    
    XCTAssertEqual(
      [1,2,3].map(computeAndPrint(_:)).map(\.1),
      [["effect: 2"], ["effect: 5"], ["effect: 10"]]
    )
    
    XCTAssertEqual(
      [1,2,3].map(computeAndPrint(_:)).map(\.1),
      [["effect: 2"], ["effect: 5"], ["effect: 10"]]
    )
    
    let composition = computeAndPrint
      >=> incr(_:)
      >>> computeAndPrint(_:)
      >=> square(_:)
      >>> computeAndPrint(_:)
    
    XCTAssertEqual(
      [1,2,3].map(composition).map(\.0),
      [10001, 1874162, 221533457]
    )
    
    XCTAssertEqual(
      [1,2,3].map(composition).map(\.1),
      [
        ["effect: 2", "effect: 10", "effect: 10001"],
        ["effect: 5", "effect: 37", "effect: 1874162"],
        ["effect: 10", "effect: 122", "effect: 221533457"]
      ]
    )
    
    let _ = String.init(utf8String:) >=> URL.init(string:)
    
    XCTAssertEqual(
      greet(at: Date(timeIntervalSince1970: 23), name: "blob"),
      "Hello blob! It's 23 seconds past the minute."
    )
    
    XCTAssertEqual(
      "blob" |> greet(at: Date(timeIntervalSince1970: 23)) >>> uppercased(_:),
      "HELLO BLOB! IT'S 23 SECONDS PAST THE MINUTE."
    )
    
    XCTAssertEqual(
      "blob" |> uppercased(_:) >>> greet(at: Date(timeIntervalSince1970: 23)),
      "Hello BLOB! It's 23 seconds past the minute."
    )
  }
  
  func test_pointFree_0003() {
    let style = fill() <> hide()
    
    let view: View = View()
    view |> style
    XCTAssertEqual(view.hide, true)
    XCTAssertEqual(view.x, 9)
    
    
    let view2: View = View() |> (from(style))
    XCTAssertEqual(view2.hide, true)
    XCTAssertEqual(view2.x, 9)
  }
}

private func incr(_ x: Int) -> Int {
  x + 1
}

private func square(_ x: Int) -> Int {
  x * x
}

private func compute(_ x: Int) -> Int {
  x * x + 1
}

private func computeWithEffect(_ x: Int) -> Int {
  let v = x * x + 1
  printed += "effect: \(v)"
  return v
}

private func computeAndPrint(_ x: Int) -> (Int, [String]) {
  let v = x * x + 1
  return (v, ["effect: \(v)"])
}

var printed = ""

private func greetWithEffect(_ name: String) -> String {
  let seconds = Int(Date().timeIntervalSince1970) % 60
  return "Hello \(name)! It's \(seconds) seconds past the minute."
}

private func greet(at date: Date, name: String) -> String {
  let seconds = Int(date.timeIntervalSince1970) % 60
  return "Hello \(name)! It's \(seconds) seconds past the minute."
}

private func greet(at date: Date = .init()) -> (_ name: String) -> String {
  { name in
    let seconds = Int(date.timeIntervalSince1970) % 60
    return "Hello \(name)! It's \(seconds) seconds past the minute."
  }
}

private func uppercased(_ str: String) -> String {
  str.uppercased()
}

class View {
  var x = 0
  var hide = false
}

func fill(_ x: Int = 9) -> (_ view: View) -> Void {
  { $0.x = x }
}

func hide(_ hide: Bool = true) -> (_ view: View) -> Void {
  { $0.hide = hide }
}
