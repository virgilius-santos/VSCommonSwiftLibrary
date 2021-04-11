import Foundation

// MARK: Function Signature

public typealias Func<A, B> = (A) -> B

// MARK: Generic Functions

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
  { a, b in f(a)(b) }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
  { a in { b in f(a, b) } }
}

public func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
  { a in { b in { c in f(a, b, c) }}}
}

public func zurry<A>(_ f: () -> A) -> A {
  f()
}

public func flip<A, B, C, D>(_ f: @escaping (A) -> (B) -> (C) -> D) -> (B) -> (C) -> (A) -> D {
    { b in { c in { a in f(a)(b)(c) } }}
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
  { b in { a in f(a)(b) } }
}

public func flip<A, C>(_ f: @escaping (A) -> () -> C) -> () -> (A) -> C {
  { { a in f(a)() } }
}

public func filter<A>(_ p: @escaping (A) -> Bool) -> ([A]) -> [A] {
  { $0.filter(p) }
}

public func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
  { pair in
    (pair.0, f(pair.1))
  }
}

public func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
  { pair in
    (f(pair.0), pair.1)
  }
}

public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
  { xs in xs.map(f) }
}

public func map<A, B>(_ f: @escaping (A) -> B) -> (A?) -> B? {
  { $0.map(f) }
}

public func from<A>(
  _ f: @escaping (inout A) -> Void
) -> ((A) -> A) {
  { a in
    var copy = a
    f(&copy)
    return copy
  }
}

public func from<A: AnyObject>(
  _ f: @escaping (A) -> Void
) -> ((A) -> A) {
  { a in
    f(a)
    return a
  }
}

public func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>
) -> (@escaping (Value) -> Value) -> (Root) -> Root {
  { update in
    { root in
      var copy = root
      copy[keyPath: kp] = update(copy[keyPath: kp])
      return copy
    }
  }
}

public func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>,
  _ f: @escaping (Value) -> Value
) -> (Root) -> Root {
  prop(kp)(f)
}

public func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>,
  _ value: Value
) -> (Root) -> Root {
  prop(kp, { _ in value })
}

public typealias Setter<S, T, A, B> = (@escaping (A) -> B) -> (S) -> T

public func over<S, T, A, B>(
  _ setter: Setter<S, T, A, B>,
  _ f: @escaping (A) -> B
) -> (S) -> T {
  setter(f)
}

public func set<S, T, A, B>(
  _ setter: Setter<S, T, A, B>,
  _ value: B
) -> (S) -> T {
  over(setter, { _ in value })
}

func reduce<A, R>(
  _ accumulator: @escaping (R, A) -> R
) -> (R) -> ([A]) -> R {
  { initialValue in
    { collection in
      collection.reduce(initialValue, accumulator)
    }
  }
}
