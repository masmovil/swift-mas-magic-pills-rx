import XCTest
import Foundation
import RxSwift
import RxMagicPills

class ObservableBindingTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func test_bind_observer_to_anyobservable() {
        let observer = PublishSubject<Int>()
        let observable = BehaviorSubject<Int>(value: 2)

        observer ~> observable ~~> disposeBag

        observer.on(.next(5))
        XCTAssertEqual(try? observable.value(), 5)

        observer.on(.next(6))
        XCTAssertEqual(try? observable.value(), 6)
    }

    func test_bind_observable_into_closure() {
        let expect = expectation(description: "Receive propper value")

        let observable = Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onCompleted()

            return Disposables.create()
        }

        observable ~> { value in
            if value == 1 {
                expect.fulfill()
            }
        } ~~> disposeBag

        waitForExpectations(timeout: 1)
    }
}
