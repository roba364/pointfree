//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

struct User {
    let id: Int
    let email: String
}

let user = User(id: 1, email: "blob@poinfree.co")
user.id
user.email

let f = { (user: User) in user.id } >>> String.init

\User.id // KeyPath<User, Int>

user[keyPath: \User.id]

func gett<Root, Value>(_ kp: KeyPath<Root, Value>) -> (Root) -> Value {
    return { root in
        root[keyPath: kp]
    }
}

gett(\User.id) >>> String.init

extension User {
    var isStaff: Bool {
        return self.email.hasPrefix("@pointfree.co")
    }
}

user.isStaff
\User.isStaff
user[keyPath: \User.isStaff]

let users = [
    User(id: 1, email: "ser@gmail.com"),
    User(id: 2, email: "bor@gmail.com"),
    User(id: 3, email: "lol@gmail.com"),
    User(id: 4, email: "kek@gmail.com"),
]

extension Sequence {
    func map<Value>(_ kp: KeyPath<Element, Value>) -> [Value] {
        self.map { $0[keyPath: kp]}
    }
}

users
    .map(\.email)
//users
//    .filter(\.isStaff)

users.sorted(by: { $0.email < $1.email })

struct Episode {
    let title: String
    let viewCount: Int
}

let episodes = [
    Episode(title: "1", viewCount: 242),
    Episode(title: "1", viewCount: 333),
    Episode(title: "1", viewCount: 444),
    Episode(title: "1", viewCount: 555)
]

episodes.reduce(0) { $0 + $1.viewCount }
