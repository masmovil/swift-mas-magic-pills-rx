import Foundation

protocol PowerTabBarDataSource: class {
    func tabBarItems() -> [UITabBarItem]
    func tabBarAnimator() -> PowerTabBarAnimatable
}
