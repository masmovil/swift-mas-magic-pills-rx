import XCTest
import Foundation
import RxSwift
import RxMagicPills

class DisposableBindingTests: XCTestCase {
    func test_disposable_binding() {
        var disposeBag: DisposeBag! = DisposeBag()
        let value1 = 11
        let value2 = 22
        let value3 = 33
        let observer = PublishSubject<Int>()
        let observable = BehaviorSubject<Int>(value: value1)

        //Bind 👀
        observer ~> observable ~~> disposeBag
        //Or: disposeBag <~~ observer ~> observable
        //Or: disposeBag <~~ observable <~ observer

        //Check relationship
        XCTAssertEqual(try? observable.value(), value1)
        observer.on(.next(value2))
        XCTAssertEqual(try? observable.value(), value2)

        //Destroy all binding
        disposeBag = nil

        //If a the observer get a new value, the observable still on last value
        observer.on(.next(value3))
        XCTAssertEqual(try? observable.value(), value2)
    }
}
