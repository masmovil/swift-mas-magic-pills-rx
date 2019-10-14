import Foundation
import RxSwift

public extension ObservableConvertibleType {
    /**
     Creates new subscription and sends elements to observer and link in the disposable container provided.
     
     - parameter to: Observers to receives events.
     - parameter in: `DisposeBag` or `CompositeDisposable` instance to control the lifecycle of the subscriptions.
     - returns: disposable collection
     */
    @discardableResult
    func subscribe<D: ObserverType, C: DisposableContainer>(to observer: D, in container: C) -> C where Element == D.Element {
        let disposable = asObservable().subscribe(observer)
        container.insert(disposable)
        return container
    }
}
