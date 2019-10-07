import UIKit

public protocol PowerTabBarAnimatable {
    func prepareForAnimation(_ tabBar: UIView,
                             containers: [PowerTabBarContainer],
                             initialIndex: Int)
    func performAnimation(_ fromIndex: Int,
                          toIndex: Int,
                          tabBar: UIView,
                          containers: [PowerTabBarContainer],
                          completion: @escaping () -> Void)
}
