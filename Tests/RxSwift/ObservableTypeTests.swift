import XCTest
import Foundation
import RxSwift
import RxMagicPills

class ObservableTypeTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func test_subscribeOnNext() {
        let expect = expectation(description: "Receive propper value")

        let observable = Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onCompleted()

            return Disposables.create()
        }

        observable.subscribeOnNext { value in
            if value == 1 {
                expect.fulfill()
            }
        }.disposed(by: disposeBag)

        waitForExpectations(timeout: 1)
    }
}
