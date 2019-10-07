import UIKit
import RxCocoa
import RxSwift

class PowerTabBar: UIView {

    private let disposeBag = DisposeBag()

    // MARK: - Public Properties
    weak var tabBarDataSource: PowerTabBarDataSource? {
        didSet { self.configure() }
    }
    weak var tabBarDelegate: PowerTabBarDelegate? {
        didSet { self.changeIconState(forIndex: self.initialIndex, isInitial: true) }
    }

    // MARK: - Private Properties
    private(set) var selectedIndex: Int
    private(set) var initialIndex: Int
    private(set) var animator: PowerTabBarAnimatable!
    private var tabBarItemContainers = [UIView]()
    private var animatedTabBarItems = [PowerTabBarContainer]()

    // MARK: - Initialiser
    init(initialIndex: Int, backgroundColor: UIColor) {
        self.initialIndex = initialIndex
        self.selectedIndex = initialIndex
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var totalTabs: Int {
        return tabBarDataSource?.powerTabBarViewControllers.count ?? 0
    }

    // MARK: - Private Methods

    private func configure() {
        guard let dataSource = tabBarDataSource else {
            return
        }

        animator = dataSource.powerTabBarAnimator

        let containerRects = createContainerRects()
        createTabBarItems(usingContainerRects: containerRects)

        animator.prepareForAnimation(self,
                                     containers: animatedTabBarItems,
                                     initialIndex: initialIndex)
    }

    private func createContainerRects() -> [CGRect] {
        var rects = [CGRect]()
        for index in 0..<totalTabs {
            let containerRect = createTabBarItemContainerRect(atIndex: index)
            rects.append(containerRect)
        }
        return rects
    }

    private func createTabBarItemContainerRect(atIndex index: Int) -> CGRect {
        let containerWidth = frame.width / CGFloat(totalTabs)
        let containerHeight = frame.height
        let containerRect = CGRect(x: CGFloat(index) * containerWidth,
                                   y: 0,
                                   width: containerWidth,
                                   height: containerHeight)

        return containerRect
    }

    private func createTabBarItems(usingContainerRects rects: [CGRect]) {
        guard let dataSource = self.tabBarDataSource else { return }

        for (index, rect) in rects.enumerated() {
            let containerRect = rect

            let animatedTabBarItem = PowerTabBarItem(frame: containerRect)
            let viewController = dataSource.powerTabBarViewControllers[index]
            animatedTabBarItem.append(image: viewController.powerTabBarItemImage,
                                      selectedImage: viewController.powerTabBarItemSelectedImage,
                                      title: viewController.powerTabBarItemTitle,
                                      accessibilityLabel: viewController.powerTabBarItemAccessibilityLabel)
            animatedTabBarItems.append(animatedTabBarItem)

            let powerButton = PowerButton(frame: containerRect)
            powerButton.tag = index
            powerButton.tap.subscribe(onNext: { [weak self] tag in
                self?.touchUpInside(tag: tag)
            }).disposed(by: disposeBag)

            self.addSubview(powerButton)
            self.addSubview(animatedTabBarItem)
            self.bringSubviewToFront(animatedTabBarItem)
            self.bringSubviewToFront(powerButton)
        }
    }

    private func touchUpInside(tag: Int) {
        animator.performAnimation(selectedIndex,
                                  toIndex: tag,
                                  tabBar: self,
                                  containers: animatedTabBarItems) {
                                    guard self.selectedIndex != tag else { return }
                                    self.changeIconState(forIndex: tag, isInitial: false)
        }
    }

    private func changeIconState(forIndex index: Int, isInitial: Bool) {
        self.animatedTabBarItems[index].set(isSelected: true)
        if !isInitial {
            self.animatedTabBarItems[self.selectedIndex].set(isSelected: false)
        }
        self.selectedIndex = index
        self.tabBarDelegate?.powerTabBar(self, didSelectIndex: index)
    }
}
