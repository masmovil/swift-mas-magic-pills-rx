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
    }
}

class ExamplePowerTabBar: PowerTabBarController, PowerTabBarControllerDelegate, PowerTabBarControllerDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.controllerDataSource = self
        self.controllerDelegate = self
    }

    func powerTabBarController(_ powerTabBarController: PowerTabBarController, didSelectIndex: Int) {

    }

    var powerTabBarControllerInitialIndex: Int {
        return 0
    }

    var powerTabBarControllerViewControllers: [PowerTabbableViewController] {
        return [PowerSubTabBar(), PowerSubTabBar2()]
    }

    var powerTabBarHeight: CGFloat {
        return 40
    }

    var powerTabBarBackgroundColor: UIColor {
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
