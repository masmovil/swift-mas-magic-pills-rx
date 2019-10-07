import UIKit

public protocol PowerTabBarControllerDataSource: class {
    var powerTabBarControllerInitialIndex: Int { get }
    var powerTabBarControllerViewControllers: [PowerTabbableViewController] { get }
    var powerTabBarHeight: CGFloat { get }
    var powerTabBarBackgroundColor: UIColor { get }
    var powerTabBarAnimator: PowerTabBarAnimatable { get }
    var powerTabBarItemsColors: [UIColor] { get }
}

public extension PowerTabBarControllerDataSource {
    var powerTabBarAnimator: PowerTabBarAnimatable {
        return PowerSlidingOverlayAnimator(tabColors: powerTabBarItemsColors)
    }

    var powerTabBarItemsColors: [UIColor] {
        return powerTabBarControllerViewControllers.map { _ in UIColor.clear }
    }
}
