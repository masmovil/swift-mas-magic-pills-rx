import XCTest
import Foundation
import RxSwift
import RxMagicPills

class PowerButtonTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func test_tap() {
        let expect = expectation(description: "Tap Expected")
        let button = PowerButton()
        button.tag = 3

        button.tap.subscribeOnNext { value in
            if value == button.tag {
                expect.fulfill()
            }
        }.disposed(by: disposeBag)

        button.buttonTap()

        waitForExpectations(timeout: 1)
    }
}
