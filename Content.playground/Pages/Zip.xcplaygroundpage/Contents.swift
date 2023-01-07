//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//public func zip<Sequence1, Sequence2>(
//    _ sequence1: Sequence1,
//    _ sequence2: Sequence2
//) -> Zip2Sequence<Sequence1, Sequence2> where Sequence1: Sequence, Sequence2: Sequence {
//    ...
//}

Array(zip([1, 2, 3], ["one", "two", "three"]))

let xs = [2, 3, 5, 7, 11]
Array(zip(xs.indices, xs))
Array(xs.enumerated())

let ys = xs.suffix(2)
Array(zip(ys.indices, ys))
Array(ys.enumerated())

Array(zip(xs.dropFirst(1), xs))
zip(xs.dropFirst(), xs).forEach { p, q in
    p - q == 2
    ? print("\(p) and \(q) are twin primes")
    : print("\(p) and \(q) are NOT twin primes :(")
}

for idx in xs.indices.dropFirst() {
    let p = xs[idx]
    let q = xs[xs.index(before: idx)]
    p - q == 2
    ? print("\(p) and \(q) are twin primes")
    : print("\(p) and \(q) are NOT twin primes :(")
}

let titles = [
    "Functions",
    "Side Effects",
    "Styling with Functions",
    "Algebraic Data Types"
]

//1.) Functions
//2.) Side Effects
//3.) Styling with Functions
//4.) Algebraic Data Types

titles
    .enumerated()
    .map { n, title in
        "\(n + 1).) \(title)"
    }

zip(1..., titles)
    .map { n, title in "\(n).) \(title)" }

func zip2<A, B>(_ xs: [A], _ ys: [B]) -> [(A, B)] {
    var result: [(A, B)] = []

    (0..<min(xs.count, ys.count)).forEach { idx in
        result.append((xs[idx], ys[idx]))
    }

    return result
}

zip2([1, 2, 3], ["one", "two", "three"])

func zip3<A, B, C>(
    _ xs: [A],
    _ ys: [B],
    _ zs: [C]
) -> [(A, B, C)] {
    return zip2(xs, zip2(ys, zs))
        .map { a, bc in (a, bc.0, bc.1) }
}

zip3([1, 2, 3], ["one", "two", "three"], [true, false, true ])

func zip2<A, B, C>(
    with f: @escaping (A, B) -> C
) -> ([A], [B]) -> [C] {

    return { xs, ys in zip2(xs, ys).map(f) }
}

zip2(with: +)([1, 2, 3], [4, 5, 6])

func zip3<A, B, C, D>(
    with f: @escaping (A, B, C) -> D
) -> ([A], [B], [C]) -> [D] {

    return { zip3($0, $1, $2).map(f) }
}

zip3(
    with: { $0 + $1 + $2 })([1, 2, 3], [4, 5, 6], [7, 8, 9]
    )

func zip2<A, B>(_ a: A?, _ b: B?) -> (A, B)? {
    guard let a = a, let b = b else { return nil }

    return (a, b)
}

// (A?, B?) -> (A, B)?

let a: Int? = 1
let b: Int? = 2
let c: Int? = 3

zip2(a, b)

func zip2<A, B, C>(
    with f: @escaping (A, B) -> C
) -> (A?, B?) -> C? {

    return { xs, ys in zip2(xs, ys).map(f) }
}

zip2(with: +)(a, b)

//func zip3<A, B, C, D>(
//    with f: @escaping (A, B, C) -> D
//) -> (A?, B?, C?) -> D? {
//
//    return { zip3($0, $1, $2).map(f) }
//}
//
//zip3(
//    with: { $0 + $1 + $2} )(a, b, c)

enum Result<A, E> {
    case success(A)
    case failure(E)
}

func map<A, B, E>(_ f: @escaping (A) -> B) -> (Result<A, E>) -> Result<B, E> {
    return { result in
        switch result {
        case let .success(a):
            return .success(f(a))
        case let .failure(e):
            return .failure(e)
        }
    }
}

func zip2<A, B, E>(_ a: Result<A, E>, _ b: Result<B, E>) -> Result<(A, B), E> {
    switch (a, b) {
    case let (.success(a), .success(b)):
        return .success((a, b))
    case let (.success, .failure(e)):
        return .failure(e)
    case let (.failure(e), .success):
        return .failure(e)
    case let (.failure(e1), .failure(e2)):
        // return .failure(e1 + e2)
        return .failure(e1)
    }
}

struct User {
    let email: String
    let id: Int
    let name: String
}

let emails = ["blob@pointfree.co", "blob.jr@pointfree.co", "blob.sr@pointfree.co"]
let ids = [1, 2, 3]
let names = ["Blob", "Blob junior", "Blob senior"]

