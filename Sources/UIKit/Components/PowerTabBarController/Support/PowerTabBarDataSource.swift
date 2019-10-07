import Foundation

protocol PowerTabBarDataSource: class {
    var powerTabBarViewControllers: [PowerTabbableViewController] { get }
    var powerTabBarAnimator: PowerTabBarAnimatable { get }
}
