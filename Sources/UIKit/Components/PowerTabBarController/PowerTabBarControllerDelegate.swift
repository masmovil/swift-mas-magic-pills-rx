import Foundation

public protocol PowerTabBarControllerDelegate: class {
    func powerTabBarController(_ powerTabBarController: PowerTabBarController, didSelectIndex: Int)
}

public extension PowerTabBarControllerDelegate {
    func powerTabBarController(_ powerTabBarController: PowerTabBarController, didSelectIndex index: Int) {

    }
}
