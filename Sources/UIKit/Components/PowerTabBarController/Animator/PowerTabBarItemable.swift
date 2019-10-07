import UIKit

public typealias PowerTabBarContainer = UIView & PowerTabBarItemable

public protocol PowerTabBarItemable {
    func append(image: UIImage, selectedImage: UIImage?, title: String, accessibilityLabel: String?)
    func set(isSelected: Bool)
}
