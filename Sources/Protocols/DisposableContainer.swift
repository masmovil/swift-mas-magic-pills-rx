import RxSwift

public protocol DisposableContainer {
    associatedtype DisposableReturnType

    @discardableResult
    func insert(_ disposable: Disposable) -> DisposableReturnType
}

extension DisposeBag: DisposableContainer {
    public typealias DisposableReturnType = Void
}

extension CompositeDisposable: DisposableContainer {
    public typealias DisposableReturnType = DisposeKey?
}
