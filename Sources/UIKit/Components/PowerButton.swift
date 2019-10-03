import UIKit
import RxSwift

final public class PowerButton: UIButton {
    public let tap = PublishSubject<(Int)>()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    @objc
    public func buttonTap() {
        tap.onNext(tag)
    }
}
