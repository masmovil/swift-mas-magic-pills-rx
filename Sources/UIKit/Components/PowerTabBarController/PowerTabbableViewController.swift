import UIKit

public typealias PowerTabbableViewController = PowerTabBarViewController & UIViewController

public protocol PowerTabBarViewController {
    var powerTabBarItemImage: UIImage { get }
    var powerTabBarItemSelectedImage: UIImage? { get }
    var powerTabBarItemTitle: String { get }
    var powerTabBarItemAccessibilityLabel: String? { get }
}

public extension PowerTabBarViewController {
    var powerTabBarItemSelectedImage: UIImage? {
        return nil
    }

    var powerTabBarItemAccessibilityLabel: String? {
        return nil
    }
}
