//: [Previous](@previous)

import UIKit

var greeting = "Hello, playground"

//: [Next](@next)

//let label = UILabel()
//with(label) {
//    $0.numberOfLines = 0
//    $0.font = .systemFont(ofSize: 17)
//    $0.textColor = .red
//}

func with<A, B>(_ a: A, _ f: (A) -> B) -> B {
    return f(a)
}

let string = "Hello"

func incr(_ x: Int) -> Int {
    x + 1
}

with(2, incr)
//with(2, incr, square)
