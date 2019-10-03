import UIKit

public class PowerZoomAnimator: PowerTabBarAnimatable {

    private var scaleX: CGFloat
    private var scaleY: CGFloat
    private var duration: Double
    private var delay: Double

    public init(scaleX: CGFloat = 1.5, scaleY: CGFloat = 1.5, duration: Double = 0.3, delay: Double = 0) {
        self.scaleX = scaleX
        self.scaleY = scaleY
        self.duration = duration
        self.delay = delay
    }

    public func prepareForAnimation(_ tabBar: UIView, containers: [PowerTabBarContainer], initialIndex: Int) {
        var itemsToDismiss = containers
        itemsToDismiss.remove(at: initialIndex)
        self.zoom(toItem: containers[initialIndex], whileDismissing: itemsToDismiss)
    }

    public func performAnimation(_ fromIndex: Int,
                                 toIndex: Int,
                                 tabBar: UIView,
                                 containers: [PowerTabBarContainer],
                                 completion: @escaping () -> Void) {

        var itemsToDismiss = containers
        itemsToDismiss.remove(at: toIndex)

        self.zoom(toItem: containers[toIndex],
                  whileDismissing: itemsToDismiss)
        completion()
    }

    fileprivate func zoom(toItem enlargeItem: PowerTabBarContainer,
                          whileDismissing otherItems: [PowerTabBarContainer]) {

        enlargeItem.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        _ = otherItems.map { item in
            item.transform = CGAffineTransform.identity
            item.set(isSelected: true)
        }

        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 4,
                       initialSpringVelocity: 1.0,
                       options: .allowUserInteraction,
                       animations: {
                        enlargeItem.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        _ = otherItems.map { item in
                            item.transform = CGAffineTransform(scaleX: 1, y: 1)
                            item.set(isSelected: false)
                        }
        })
    }
}
