
// MARK: fish operator

precedencegroup EffectfulComposition {
  associativity: left
  higherThan: ForwardApplication
}

infix operator >=>: EffectfulComposition

// MARK: Functions

public func >=> <A, B, C>(
  f: @escaping Func<A, (B, [String])>,
  g: @escaping Func<B, (C, [String])>
) -> Func<A, (C, [String])> {
  { a in
    let (b, logF) = f(a)
    let (c, logG) = g(b)
    return (c, logF + logG)
  }
}

public func >=> <A, B, C>(
  f: @escaping Func<A, B?>,
  g: @escaping Func<B, C?>
) -> Func<A, C?> {
  { a in
    guard let b = f(a) else { return nil }
    let c = g(b)
    return c
  }
}

public func >=> <A, B, C>(
  f: @escaping Func<A, [B]>,
  g: @escaping Func<B, [C]>
) -> Func<A, [C]> {
  { a in
    let bArray = f(a)
    let cArray: [C] = bArray.flatMap(g)
    return cArray
  }
}
