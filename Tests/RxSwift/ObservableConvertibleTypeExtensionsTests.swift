import XCTest
import Foundation
import RxSwift
import RxMasMagicPills

class ObservableConvertibleTypeExtensionsTests: XCTestCase {
    func test_subscribe_to_observable_in_disposebag() {
        var disposeBag: DisposeBag! = DisposeBag()
        let value1 = 11
        let value2 = 22
        let value3 = 33
        let observer = PublishSubject<Int>()
        let observable = BehaviorSubject<Int>(value: value1)

        // Subscribe 👀
        observer.subscribe(to: observable, in: disposeBag)

        // Check relationship
        XCTAssertEqual(try? observable.value(), value1)
        observer.on(.next(value2))
        XCTAssertEqual(try? observable.value(), value2)

        // Destroy all binding
        disposeBag = nil

        // If a the observer get a new value, the observable still on last value
        observer.on(.next(value3))
        XCTAssertNotEqual(try? observable.value(), value3)
    }
}
