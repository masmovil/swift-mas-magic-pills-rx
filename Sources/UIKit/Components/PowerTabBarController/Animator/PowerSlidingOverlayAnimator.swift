import UIKit

public class PowerSlidingOverlayAnimator: PowerTabBarAnimatable {

    private var tabColors: [UIColor]!
    private var rightOverlayView: UIView = UIView(frame: .zero)
    private var leftOverlayView: UIView = UIView(frame: .zero)
    private var containerWidth: CGFloat = 0
    private var numberOfContainers: Int = 0
    private var rightOverlayXPosition: CGFloat = 0 {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.rightOverlayView.frame.origin.x = self.rightOverlayXPosition
            })
        }
    }
    private var leftOverlayXPosition: CGFloat = 0 {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.leftOverlayView.frame.origin.x = self.leftOverlayXPosition
            })
        }
    }
    private let zoomAnimator = PowerZoomAnimator()

    public init(tabColors: [UIColor]) {
        self.tabColors = tabColors
    }

    public func prepareForAnimation(_ tabBar: UIView,
                                    containers: [PowerTabBarContainer],
                                    initialIndex: Int) {
        if containers.count != tabColors.count {
            fatalError("Please provide colors for all tab items. TabItems = \(containers.count) : Colors = \(tabColors.count)")
        }

        numberOfContainers = containers.count
        containerWidth = CGFloat(tabBar.frame.width / CGFloat(numberOfContainers))

        rightOverlayXPosition = CGFloat(containerWidth * CGFloat(initialIndex)) + containerWidth
        rightOverlayView = UIView(frame: CGRect(x: rightOverlayXPosition,
                                                y: 0,
                                                width: tabBar.frame.width,
                                                height: tabBar.frame.height))
        rightOverlayView.backgroundColor = tabBar.backgroundColor

        leftOverlayXPosition = CGFloat(-tabBar.frame.width) + rightOverlayXPosition - containerWidth
        leftOverlayView = UIView(frame: CGRect(x: leftOverlayXPosition,
                                               y: 0,
                                               width: tabBar.frame.width,
                                               height: tabBar.frame.height))
        leftOverlayView.backgroundColor = tabBar.backgroundColor

        tabBar.addSubview(rightOverlayView)
        tabBar.addSubview(leftOverlayView)
        tabBar.sendSubviewToBack(rightOverlayView)
        tabBar.sendSubviewToBack(leftOverlayView)

        let colorContainers = self.createOverlayContainers(forContainers: containers, withColors: tabColors)

        for container in colorContainers {
            tabBar.addSubview(container)
            tabBar.sendSubviewToBack(container)
        }

        zoomAnimator.prepareForAnimation(tabBar, containers: containers, initialIndex: initialIndex)
    }

    public func performAnimation(_ fromIndex: Int,
                                 toIndex: Int,
                                 tabBar: UIView,
                                 containers: [PowerTabBarContainer],
                                 completion: @escaping () -> Void) {
        rightOverlayXPosition = CGFloat(containerWidth * CGFloat(toIndex)) + containerWidth
        leftOverlayXPosition = CGFloat(-tabBar.frame.width) + rightOverlayXPosition - containerWidth
        zoomAnimator.performAnimation(fromIndex, toIndex: toIndex, tabBar: tabBar, containers: containers, completion: {
            completion()
        })
    }

    private func createOverlayContainers(forContainers containers: [PowerTabBarContainer], withColors colors: [UIColor]) -> [UIView] {
        var views = [UIView]()
        for (index, container) in containers.enumerated() {
            let rect = CGRect(x: CGFloat(index) * containerWidth,
                              y: 0,
                              width: containerWidth,
                              height: container.frame.height)
            let view = UIView(frame: rect)
            view.backgroundColor = colors[index]
            views.append(view)
        }
        return views
    }
}
