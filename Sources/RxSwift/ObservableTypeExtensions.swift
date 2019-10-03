import Foundation
import RxSwift

public extension ObservableType {
    /**
     Subscribes an element handler to an observable sequence.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    func subscribeOnNext(_ onNext: @escaping (Self.Element) -> Void) -> RxSwift.Disposable {
        return subscribe(onNext: onNext)
    }
}
