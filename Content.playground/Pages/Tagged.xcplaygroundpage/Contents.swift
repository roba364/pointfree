//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

let usersJson = """
[
{
"id": 1,
"name": "Brandon",
"age": 32,
"email": "brandon@pointfree.co",
"subscriptionId": 1
},
{
"id": 2,
"name": "Stephen",
"age": 22,
"email": "stephen@pointfree.co",
"subscriptionId": null
},
{
"id": 3,
"name": "Blob",
"age": 10,
"email": "blob@pointfree.co",
"subscriptionId": 1
}
]
"""

let subscriptionsJson = """
[
{
"id": 1,
"ownerId": 1
}
]
"""

struct Tagged<Tag, RawValue> {
    let rawValue: RawValue
}

extension Tagged: Decodable where RawValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(rawValue: try container.decode(RawValue.self))
    }
}

extension Tagged: Equatable where RawValue: Equatable {

}

struct Subscription: Decodable {
//    struct ID: Decodable, RawRepresentable, Equatable {
//        let rawValue: Int
//    }
    typealias ID = Tagged<Subscription, Int>

    let id: ID
    let ownerId: User.ID
}

//RawRepresetable

//struct Email: Decodable, RawRepresentable {
//    let rawValue: String
//}

enum EmailTag { }
typealias Email = Tagged<EmailTag, String>
enum AgeTag { }

// "email": { "email": String }
// Subscription.init(from: Decoder)

struct User: Decodable {
    typealias ID = Tagged<User, Int>
    typealias AGE = Tagged<User, Int>

    let id: ID
    let age: AGE
    let name: String
    let email: Email
    let subscriptionId: Subscription.ID?
}

let decoder = JSONDecoder()
let users = try! decoder.decode([User].self, from: Data(usersJson.utf8))
let subscriptions = try! decoder.decode([Subscription].self, from: Data(subscriptionsJson.utf8))

func sendEmail(email: Email) {
    //
}

let user = users[0]
sendEmail(email: user.email)

subscriptions.first(where: { $0.id == user.subscriptionId })
subscriptions.first(where: { $0.ownerId == user.id })

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
    init(integerLiteral value: RawValue.IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: value))
    }

    typealias IntegerLiteralType = RawValue.IntegerLiteralType
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
    typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType

    init(unicodeScalarLiteral value: RawValue.UnicodeScalarLiteralType) {
        self.init(rawValue: RawValue(unicodeScalarLiteral: value))
    }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
    init(extendedGraphemeClusterLiteral value: RawValue.ExtendedGraphemeClusterLiteralType) {
        self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: value))
    }

    typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
    typealias StringLiteralType = RawValue.StringLiteralType

    init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: value))
    }
}

extension Tagged: Comparable where RawValue: Comparable {
    static func < (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

let son = User(id: .init(rawValue: 1),
     age: 32,
     name: "Rob",
     email: .init(rawValue: "rob@gmail.com"),
     subscriptionId: .init(rawValue: 123))

// ExpressibleByIntegerLiteral

let serj = User(id: 1,
     age: 32,
     name: "Rob",
     email: "rob@gmail.com",
     subscriptionId: 12345)

var users1 = users

users1.sort(by: { $0.id > $1.id })

serj.age

let above15 = users.map { $0.age }
above15
