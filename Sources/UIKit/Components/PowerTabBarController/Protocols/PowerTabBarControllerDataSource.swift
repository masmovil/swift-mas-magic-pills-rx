import UIKit

public protocol PowerTabBarControllerDataSource: class {
    func tabBarControllerInitialIndex() -> Int
    func tabBarControllerViewControllers() -> [PowerTabbableViewController]
    func tabBarHeight() -> CGFloat
    func tabBarBackgroundColor() -> UIColor
    func tabBarAnimator() -> PowerTabBarAnimatable
}
