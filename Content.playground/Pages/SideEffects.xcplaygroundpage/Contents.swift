import UIKit
import XCTest

var greeting = "Hello, playground"

func compute(_ x: Int) -> Int {
    x * x + 1
}

compute(2)
compute(2)
compute(2)

assertEqual(5, compute(2))
assertEqual(6, compute(2))
assertEqual(5, compute(3))

func computeWithEffect(_ x: Int) -> Int {
    let computation = x * x + 1
    print(computation)
    return computation
}

computeWithEffect(2)
computeWithEffect(2)

print("---")

[2, 10].map(compute(_:)).map(compute(_:))

print("---")

[2, 10].map { computeWithEffect($0) }.map { computeWithEffect($0) }

print("---")

func compose<A, B, C>(
    _ f: @escaping (A) -> (B, [String]),
    _ g: @escaping (B) -> (C, [String])
) -> ((A) -> (C, [String])) {
    return { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)

        return (c, logs + moreLogs)
    }
}

print("---")

func greetWithEffect(_ name: String) -> String {
    let seconds = Int(Date().timeIntervalSince1970) % 60

    return "Hello \(name)!. It's \(seconds) seconds past the minute"
}

greetWithEffect("Rob")

print("---")

func greet(at date: Date, name: String) -> String {
    let seconds = Int(date.timeIntervalSince1970) % 60

    return "Hello \(name)!. It's \(seconds) seconds past the minute"
}

greet(at: Date(), name: "Rob")


print("---")

func greet(at date: Date) -> (String) -> String {
    return { name in
        let seconds = Int(date.timeIntervalSince1970) % 60

        return "Hello \(name)!. It's \(seconds) seconds past the minute"
    }
}

greet(at: Date())

print("---")

func toInout<A>(_ f: @escaping (A) -> A) -> (inout A) -> Void {
    return { a in
        a = f(a)
    }
}
