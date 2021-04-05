
// MARK: backwards operator

precedencegroup BackwardsComposition {
  associativity: left
}

infix operator <<<: BackwardsComposition

// MARK: Functions

public func <<< <A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
  { f(g($0)) }
}
