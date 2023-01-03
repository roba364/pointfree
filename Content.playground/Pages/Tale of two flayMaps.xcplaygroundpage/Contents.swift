//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//extension Array {
//    func flatMap<B>(_ f: @escaping (Element) -> [B]) -> [B] {
//
//    }
//}

let csv = """
1, 2, 3, 4
3, 5, 2
8, 9, 4
"""

csv
    .split(separator: "\n")
    .map { $0.split(separator: ",") }
// [["1", " 2", " 3", " 4"], ["3", " 5", " 2"], ["8", " 9", " 4"]]

__

csv
    .split(separator: "\n")
    .flatMap { $0.split(separator: ",") }
//["1", " 2", " 3", " 4", "3", " 5", " 2", "8", " 9", " 4"]

//extension Array {
//    func flatMap<B>(_ f: @escaping (Element) -> [B]) -> [B] {
//
//    }
//}

["1", "2", "buckle", "my"]
    .map(Int.init)

["1", "2", "buckle", "my"]
    .flatMap(Int.init)

csv
    .split(separator: "\n")
    .flatMap { $0.split(separator: ",") }
    .flatMap { Int($0) }
    .reduce(0, +)

extension Array {
    func filterMap<B>(_ transform: (Element) -> B?) -> [B] {
        var result = [B]()
        for x in self {
            switch transform(x) {
            case let .some(x):
                result.append(x)
            case let .none:
                continue
            }
        }
        return result
    }
}

extension Array {
    func compactMap<B>(_ transform: (Element) -> B?) -> [B] {
        var result = [B]()
        for x in self {
            switch transform(x) {
            case let .some(x):
                result.append(x)
            case let .none:
                continue
            }
        }
        return result
    }
}
