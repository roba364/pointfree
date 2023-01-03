//: [Previous](@previous)

import UIKit

var greeting = "Hello, playground"

//: [Next](@next)

func wrapView(padding: UIEdgeInsets) -> (UIView) -> UIView {
  return { subview in
    let wrapper = UIView()
    subview.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(subview)
    NSLayoutConstraint.activate([
      subview.leadingAnchor.constraint(
        equalTo: wrapper.leadingAnchor, constant: padding.left
      ),
      subview.rightAnchor.constraint(
        equalTo: wrapper.rightAnchor, constant: -padding.right
      ),
      subview.topAnchor.constraint(
        equalTo: wrapper.topAnchor, constant: padding.top
      ),
      subview.bottomAnchor.constraint(
        equalTo: wrapper.bottomAnchor, constant: -padding.bottom
      ),
      ])
    return wrapper
  }
}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = .darkGray

let padding = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)

let wrapper = wrapView(padding: padding)(view)
wrapper.frame.size = CGSize(width: 300, height: 300)
wrapper.backgroundColor = .lightGray
wrapper

wrapView(padding: padding) as (UIView) -> UIView
wrapView(padding: padding) as (UIButton) -> UIView
wrapView(padding: padding) as (UISwitch) -> UIView
wrapView(padding: padding) as (UIStackView) -> UIView

//wrapView(padding: padding) as (UIResponder) -> UIView
//wrapView(padding: padding) as (UIView) -> UIButton
wrapView(padding: padding) as (UIView) -> UIResponder
wrapView(padding: padding) as (UIView) -> NSObject
wrapView(padding: padding) as (UIView) -> AnyObject
