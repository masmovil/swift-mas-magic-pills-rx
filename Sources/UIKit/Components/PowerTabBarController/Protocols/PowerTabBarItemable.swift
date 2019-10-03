import UIKit

public typealias PowerTabBarContainer = UIView & PowerTabBarItemable

public protocol PowerTabBarItemable {
    func append(item: UITabBarItem)
    func set(isSelected: Bool)
}
