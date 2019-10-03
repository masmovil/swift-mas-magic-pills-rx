import UIKit
import RxCocoa
import RxSwift

open class PowerTabBarController: UITabBarController {

    private let disposeBag = DisposeBag()

    // MARK: - Properties
    public weak var controllerDataSource: PowerTabBarControllerDataSource? { didSet { self.configureViews() } }
    public weak var controllerDelegate: PowerTabBarControllerDelegate?

    // MARK: - Initialiser
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("")
    }

    // MARK: - Private Methods
    private var powerTabBar: PowerTabBar!

    private func configureViews() {
        guard let dataSource = self.controllerDataSource else { return }
        tabBar.isHidden = true
        viewControllers = dataSource.tabBarControllerViewControllers()
        powerTabBar = PowerTabBar(initialIndex: dataSource.tabBarControllerInitialIndex(),
                                  backgroundColor: dataSource.tabBarBackgroundColor())
        view.addSubview(powerTabBar)
        setupUITabBarConstraints(height: dataSource.tabBarHeight())
        powerTabBar.tabBarDataSource = self
        powerTabBar.tabBarDelegate = self

        self.rx.didSelect
            .asObservable()
            .debug("tab bar tap", trimOutput: false)
            .subscribe(onNext: { _ in
                print("result")
            }).disposed(by: disposeBag)
    }

    private func setupUITabBarConstraints(height: CGFloat) {
        powerTabBar.translatesAutoresizingMaskIntoConstraints = false
        powerTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        powerTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        if #available(iOS 11.0, *) {
            powerTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            let bottomView = UIView(frame: .zero)
            bottomView.backgroundColor = powerTabBar.backgroundColor
            view.addSubview(bottomView)
            bottomView.translatesAutoresizingMaskIntoConstraints = false
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            powerTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }

        powerTabBar.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.view.layoutIfNeeded()
    }
}

extension PowerTabBarController: PowerTabBarDelegate, PowerTabBarDataSource {
    public func didSelect(index: Int) {
        self.selectedIndex = index
    }

    public func tabBarAnimator() -> PowerTabBarAnimatable {
        guard let _ = controllerDataSource else { fatalError() }
        return PowerSlidingOverlayAnimator(tabColors: [.white, .black, .red])
    }

    public func tabBarItems() -> [UITabBarItem] {
        guard let dataSource = controllerDataSource else { fatalError() }
        return dataSource.tabBarControllerViewControllers().map { $0.powerTabBarItem }
    }
}
