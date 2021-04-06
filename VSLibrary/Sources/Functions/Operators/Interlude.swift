
// MARK: interlude operator

precedencegroup FowardComposition {
  associativity: left
  higherThan: ForwardApplication, EffectfulComposition
}

infix operator >>>: FowardComposition

// MARK: Functions

public func >>> <A, B, C>(
  f: @escaping Func<A, B>,
  g: @escaping Func<B, C>
) -> Func<A, C> {
  { g(f($0)) }
}
