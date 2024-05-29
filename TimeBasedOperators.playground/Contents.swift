import RxSwift
import RxCocoa
import UIKit
import PlaygroundSupport

let disposeBag = DisposeBag()

print("----------replay----------")
let greetings = PublishSubject<String>()
let parrotRepeating = greetings.replay(1)
parrotRepeating.connect()

greetings.onNext("1. hello")
greetings.onNext("2. hi")

parrotRepeating
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

greetings.onNext("3. hola")

print("----------replayAll----------")
let drStrange = PublishSubject<String>()
let timeStone = drStrange.replayAll()
timeStone.connect()

drStrange.onNext("Dormammu!")
drStrange.onNext("I've come to bargain.")

timeStone
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------buffer----------")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("----------window----------")
//let numberOfMaxObservablesCreated = 5
//let timeCreating = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSource.resume()
//
//window
//    .window(
//        timeSpan: timeCreating,
//        count: numberOfMaxObservablesCreated,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { (windowObservable: Observable<String>) -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("#\($0.index) Observable's element \($0.element)")
//    })
//    .disposed(by: disposeBag)

print("----------delaySubscription----------")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimerSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("----------delay----------")
//let delaySubject = PublishSubject<Int>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext(delayCount)
//}
//delayTimerSource.resume()
//
//delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("----------interval----------")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("----------timer----------")
//Observable<Int>
//    .timer(
//        .seconds(5),
//        period: .seconds(2),
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("----------timeout----------")
let errorIfNotPressed = UIButton(type: .system)
errorIfNotPressed.setTitle("Press me!", for: .normal)
errorIfNotPressed.sizeToFit()

PlaygroundPage.current.liveView = errorIfNotPressed

errorIfNotPressed.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)








