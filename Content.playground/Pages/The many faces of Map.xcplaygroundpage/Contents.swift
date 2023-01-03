//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

[1, 2, 3]
    .map { $0 + 1 }
[1, 2, 3]
    .map(incr)

func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    return { xs in
        var result = [B]()
        xs.forEach { result.append(f($0)) }
        return result
    }
}

Int?.some(2)
    .map(incr)
Int?.none
    .map(incr)

func id<A>(_ a: A) -> A {
    return a
}

[1, 2, 3]
    .map { $0 }
[1, 2, 3]
    .map(id)

//let xs = [1, 2, 3, 4]
//let f = incr
//let g = { (x: Int) in String(x) }
//
//let lhs = lift(f) >>> map(g)
//let rhs = map(f) >>> lift(g)
//
//lhs(xs) == rhs(xs)

enum Result<A, E> {
    case succes(A)
    case failure(E)
}

struct F1<A> {
    let value: A
}

func map<A, B>(_ f: @escaping (A) -> B) -> (F1<A>) -> F1<B> {
    return { f1 in
        F1(value: f(f1.value))
    }
}
