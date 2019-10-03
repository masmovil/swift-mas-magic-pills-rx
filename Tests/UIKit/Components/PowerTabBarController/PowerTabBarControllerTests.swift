import XCTest
import Foundation
import RxSwift
import RxMagicPills

class PowerTabBarControllerTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func test_create_example() {
        let tabBarController = ExamplePowerTabBar()

        tabBarController.selectedIndex = 0
        tabBarController.selectedIndex = 1
        tabBarController.selectedIndex = 2
    }
}

class ExamplePowerTabBar: PowerTabBarController, PowerTabBarControllerDelegate, PowerTabBarControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.controllerDataSource = self
        self.controllerDelegate = self
    }

    func tabBarItem() -> UITabBarItem {
        return UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
    }

    func tabBar(_ tabBarController: PowerTabBarController, index: Int) {

    }

    func tabBarControllerInitialIndex() -> Int {
        return 0
    }

    func tabBarControllerViewControllers() -> [PowerTabbableViewController] {
        return [PowerSubTabBar(), PowerSubTabBar2(), PowerSubTabBar3()]
    }

    func tabBarHeight() -> CGFloat {
        return 40
    }

    func tabBarBackgroundColor() -> UIColor {
        return .red
    }
}

class PowerSubTabBar: PowerTabbableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    var powerTabBarItem: UITabBarItem {
        let image = UIImage(named: "tabBarIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        return tabBarItem
    }
}

class PowerSubTabBar2: PowerTabbableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    var powerTabBarItem: UITabBarItem {
        let image = UIImage(named: "tabBarIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        return tabBarItem
    }
}

class PowerSubTabBar3: PowerTabbableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    var powerTabBarItem: UITabBarItem {
        let image = UIImage(named: "tabBarIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        return tabBarItem
    }
}
