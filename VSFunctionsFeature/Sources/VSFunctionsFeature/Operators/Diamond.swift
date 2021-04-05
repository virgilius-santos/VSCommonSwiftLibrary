
// MARK: diamond operator

precedencegroup SingleTypeComposition {
  associativity: left
  higherThan: ForwardApplication
}

infix operator <>: SingleTypeComposition

// MARK: Functions

public func <> <A>(f: @escaping Func<A, A>, g: @escaping Func<A, A>) -> Func<A, A> {
  f >>> g
}

public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
  { a in
    f(&a)
    g(&a)
  }
}

public func <> <A: AnyObject>(f: @escaping Func<A, Void>, g: @escaping Func<A, Void>) -> Func<A, Void> {
  { a in
    f(a)
    g(a)
  }
}
