
// MARK: pipe-forward operator

precedencegroup ForwardApplication {
  associativity: left
}

infix operator |>: ForwardApplication

// MARK: Functions

public func |> <A, B>(a: A, f: Func<A, B>) -> B { f(a) }

public func |> <A>(a: inout A, f: (inout A) -> Void) -> Void { f(&a) }

public func |> <A: AnyObject, B: AnyObject>(input: (A, B), f: Func<(A, B), Void>) -> Void {
  f(input)
}

@discardableResult public func |> <A>(_ a: A, _ f: (inout A) -> Void) -> A {
  var a = a
  f(&a)
  return a
}
