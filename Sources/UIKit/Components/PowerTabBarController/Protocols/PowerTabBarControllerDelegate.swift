import Foundation

public protocol PowerTabBarControllerDelegate: class {
    func powerTabBarController(_ powerTabBarController: PowerTabBarController, didSelectIndex: Int)
}
