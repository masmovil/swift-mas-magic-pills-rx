import Foundation
import RxCocoa
import RxSwift
import MasMagicPills

public extension ObservableConvertibleType {
    /**
    Converts observable sequence to `Driver` trait.
    - returns: Driver trait.
    */
    func asDriver() -> Driver<Element> {
        return asDriver(onErrorDriveWith: .never())
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy, Element == String {
    var uppercased: Driver<Element> {
        return map { $0.uppercased() }
    }

    var lowercased: Driver<Element> {
        return map { $0.lowercased() }
    }

    var capitalizedFirstLetter: Driver<Element> {
        return map { $0.capitalizedFirstLetter }
    }

    var wrapped: Driver<Element?> {
        return map(Optional.init)
    }

    var internetUrlValue: Driver<URL?> {
        return map { $0.internetUrlValue }
    }

    var urlValue: Driver<URL?> {
        return map { $0.urlValue }
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy, Element == Bool {
    var not: Driver<Bool> {
        return map { !$0 }
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy {
    func driveOnNext(_ onNext: @escaping (Element) -> Void) -> RxSwift.Disposable {
        return drive(onNext: onNext)
    }

    func driveOnNext(_ onNext: @escaping (Element) -> Void, bag: DisposeBag) {
        drive(onNext: onNext).disposed(by: bag)
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy, Element: OptionalType {
    /**
     Unwraps and filters out `nil` elements.
     - returns: `Observable` of source `Observable`'s elements, with `nil` elements filtered out.
     */
    func filterNils() -> Driver<Element.Wrapped> {
        return self.flatMap { element -> Driver<Element.Wrapped> in
            guard let value = element.wrapped else {
                return Driver<Element.Wrapped>.empty()
            }
            return Driver<Element.Wrapped>.just(value)
        }
    }

    /* Map each element to bool that indicate if element is nil or not */
    func isNil() -> Driver<Bool> {
        return map { $0.wrapped.isNil }
    }
}
