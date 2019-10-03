import Foundation

public protocol PowerTabBarDataSource: class {
    func tabBarItems() -> [UITabBarItem]
    func tabBarAnimator() -> PowerTabBarAnimatable
}
