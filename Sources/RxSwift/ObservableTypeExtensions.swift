import Foundation
import RxSwift
import MasMagicPills

public extension ObservableType {
    /**
     Subscribes an element handler to an observable sequence.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    func subscribeOnNext(_ onNext: @escaping (Self.Element) -> Void) -> RxSwift.Disposable {
        return subscribe(onNext: onNext)
    }

    /**
     Subscribes an element handler to an observable sequence and dispose in the given bag.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - parameter bag: DisposeBag used to attach the subscription.
     */
    func subscribeOnNext(_ onNext: @escaping (Self.Element) -> Void, bag: DisposeBag) {
        subscribe(onNext: onNext)
            .disposed(by: bag)
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

    /**
     Filters the elements of an observable sequence based on the last value from the second observable.
     */
    func filteringWithLatestFrom<Source: ObservableConvertibleType>(_ second: Source) -> Observable<Self.Element> where Source.Element == Bool {
        return withLatestFrom(second) { ($0, $1) }
            .filter { $0.1 }
            .map { $0.0 }
    }
}

public extension ObservableType where Element: OptionalType {

    /**
     Unwraps and filters out `nil` elements.
     - returns: `Observable` of source `Observable`'s elements, with `nil` elements filtered out.
     */
    func filterNils() -> Observable<Element.Wrapped> {
        return self.flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.wrapped else {
                return Observable<Element.Wrapped>.empty()
            }
            return Observable<Element.Wrapped>.just(value)
        }
    }

    /* Map each element to bool that indicate if element is nil or not */
    func isNil() -> Observable<Bool> {
        return map { $0.wrapped.isNil }
    }
}

public extension ObservableType where Element == Bool {
    var not: Observable<Bool> {
        return map { !$0 }
    }
}
