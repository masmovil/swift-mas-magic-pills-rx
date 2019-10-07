import XCTest
import Foundation
import RxSwift
@testable import RxMagicPills

class PowerTabBarControllerTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func test_create() {
        let backColor = UIColor.yellow
        let height: CGFloat = 20
        let vcs: [PowerTabbableViewController] = [PowerSubTabBar(), PowerSubTabBar2(), PowerSubTabBar2()]
        let tabBarController = ExamplePowerTabBar(backColor: backColor, height: 20, initialIdx: 0, vcs: vcs)

        XCTAssertEqual(tabBarController.selectedIndex, 0)
        XCTAssertEqual(tabBarController.selectedViewController, vcs[0])

        //Internal checks:
        XCTAssertEqual(tabBarController.powerTabBar.backgroundColor, backColor)
        XCTAssertEqual(tabBarController.powerTabBar.frame.height, height)
        XCTAssertEqual(tabBarController.powerTabBar.totalTabs, vcs.count)
//        XCTAssertEqual(tabBarController.powerTabBar.tabBarItems[0].image, vcs[0].powerTabBarItem.image)
//        XCTAssertEqual(tabBarController.powerTabBar.tabBarItems[1].image, vcs[1].powerTabBarItem.image)
    }

    func test_create_pointing_to_second_tab() {
        let vcs: [PowerTabbableViewController] = [PowerSubTabBar(), PowerSubTabBar2()]

        let tabBarController = ExamplePowerTabBar(initialIdx: 1, vcs: vcs)
        XCTAssertEqual(tabBarController.selectedIndex, 1)
        XCTAssertEqual(tabBarController.selectedViewController, vcs[1])
    }
}

class ExamplePowerTabBar: PowerTabBarController, PowerTabBarControllerDelegate, PowerTabBarControllerDataSource {
    private let initialIndex: Int
    private let backColor: UIColor
    private let barHeight: CGFloat
    private let vcs: [PowerTabbableViewController]

    required init(backColor: UIColor = .clear, height: CGFloat = 30, initialIdx: Int = 0, vcs: [PowerTabbableViewController]) {
        self.initialIndex = initialIdx
        self.backColor = backColor
        self.barHeight = height
        self.vcs = vcs
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.powerDataSource = self
        self.powerDelegate = self
    }

    var powerTabBarControllerInitialIndex: Int {
        return initialIndex
    }

    var powerTabBarControllerViewControllers: [PowerTabbableViewController] {
        return vcs
    }

    var powerTabBarControllerHeight: CGFloat {
        return barHeight
    }

    var powerTabBarControllerBackgroundColor: UIColor {
        return backColor
    }
}

class PowerSubTabBar: PowerTabbableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    var powerTabBarItemImage: UIImage {
        return UIImage(named: "tabBarIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }

    var powerTabBarItemTitle: String {
        return "uno"
    }
}

class PowerSubTabBar2: PowerTabbableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    var powerTabBarItemImage: UIImage {
        return UIImage(named: "tabBarIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }

    var powerTabBarItemSelectedImage: UIImage? {
        return UIImage(named: "tabBarIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }

    var powerTabBarItemTitle: String {
        return "dos"
    }
}
