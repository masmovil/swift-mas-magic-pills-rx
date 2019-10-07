import UIKit

public protocol PowerTabBarControllerDataSource: class {
    var powerTabBarControllerInitialIndex: Int { get }
    var powerTabBarControllerViewControllers: [PowerTabbableViewController] { get }
    var powerTabBarControllerHeight: CGFloat { get }
    var powerTabBarControllerBackgroundColor: UIColor { get }
    var powerTabBarControllerAnimator: PowerTabBarAnimatable { get }
    var powerTabBarControllerItemsColors: [UIColor] { get }
}

public extension PowerTabBarControllerDataSource {
    var powerTabBarControllerInitialIndex: Int {
        return 0
    }

    var powerTabBarControllerItemsColors: [UIColor] {
        return powerTabBarControllerViewControllers.map { _ in UIColor.clear }
    }

    var powerTabBarControllerAnimator: PowerTabBarAnimatable {
        return PowerSlidingOverlayAnimator(tabColors: powerTabBarControllerItemsColors)
    }
}
