import UIKit

public typealias PowerTabbableViewController = PowerTabBarViewController & UIViewController

public protocol PowerTabBarViewController {
    var powerTabBarItem: UITabBarItem { get }
}
