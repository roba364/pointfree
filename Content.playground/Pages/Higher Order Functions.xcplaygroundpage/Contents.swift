//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

func curry<A, B, C>(
    _ f: @escaping (A, B) -> C
) -> (A) -> (B) -> C {
    return { a in { b in
        f(a, b)
    }
  }
}

func zurry<A>(_ f: () -> A) -> A {
    f()
}

func greet(at date: Date, name: String) -> String {
    let seconds = Int(date.timeIntervalSince1970) % 60
    return "Hello \(name)! It's \(seconds) seconds past the minute"
}

func greet(at date: Date) -> (String) -> String {
    return { name in
        let seconds = Int(date.timeIntervalSince1970) % 60
        return "Hello \(name)! It's \(seconds) seconds past the minute"
    }
}

curry(greet(at:name:))

func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in { a in
        f(a)(b)
    }
    }
}

[1, 2, 3]
    .map(incr)
    .map(square )

func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> ([B]) {
    return { $0.map(f) }
}

map(incr)
map(square)

Array(1...10)
    .filter { $0 > 5 }

func filter<A>(_ p: @escaping (A) -> Bool) -> ([A]) -> [A] {
    return { $0.filter(p) }
}
