import UIKit

//UIAppearance.appearance().
//UIButton.appearance().contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
//UIButton.appearance().titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
//
let roundedStyle: (UIView) -> Void = {
  $0.clipsToBounds = true
  $0.layer.cornerRadius = 6
}

func baseButtonStyle(_ button: UIButton) {
  button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
  button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
}

extension UIButton {
  static var base: UIButton {
    let button = UIButton()
    button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    return button
  }

  static var filled: UIButton {
    let button = self.base
    button.backgroundColor = .black
    button.tintColor = .white
    return button
  }

  static var rounded: UIButton {
    let button = self.filled
    button.clipsToBounds = true
    button.layer.cornerRadius = 6
    return button
  }
}

class BaseButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    self.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class RoundedButton: BaseButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.clipsToBounds = true
    self.layer.cornerRadius = 6
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class FilledButton: RoundedButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .black
    self.tintColor = .white
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
