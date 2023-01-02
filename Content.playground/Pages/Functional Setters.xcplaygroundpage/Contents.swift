//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

let pair = (42, "Swift")

(incr(pair.0), pair.1)

func incrFirst<A>(_ pair: (Int, A)) -> (Int, A) {
    return (incr(pair.0), pair.1)
}

incrFirst(pair)

func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
    return { pair in
        (f(pair.0), pair.1)
    }
}

func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
    return { pair in
        (pair.0, f(pair.1))
    }
}

pair
|> first(incr)
|> first(String.init)
|> second { $0 + "!" }

first(incr)(pair)

var copyPair = pair
copyPair.0 += 1
//copyPair.0 = String(copyPair.0)
copyPair.1 = copyPair.1.uppercased()

let nested = ((1, true), "Swift")

nested
|> first { $0 |> second { !$0 } }

precedencegroup BackwardsComposition {
    associativity: left
}
infix operator <<<: BackwardsComposition
func <<< <A, B, C>(_ f: @escaping (B) -> C,
                   _ g: @escaping (A) -> B) -> (A) -> C {
    return { f(g($0)) }
}

nested
|> (first <<< second) { !$0 }

// ((A) -> B) -> (S) -> T

// ((A) -> B) -> ((A, C)) -> (B, C)
// ((A) -> B) -> (CA, A)) -> (C, B)

// ((A) -> B) -> ([A]) -> [B]

public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    return { xs in xs.map(f) }
}

(42, ["Swift", "Objective-C"])
|> (second <<< map) { $0 + "! " }
|> first(incr)

dump(
    [(42, ["Swift", "Objective-C"]),
     (1729, ["Haskell", "Typescript"])]
    |> (map <<< second <<< map) { $0 + "!" }
)

let data = [(42, ["Swift", "Objective-C"]),
            (1729, ["Haskell", "Typescript"])]

data.map { ($0.0, $0.1.map { $0 + "!" }) }
