import RxSwift

let disposeBag = DisposeBag()

print("----------startWith----------")
let classYellow = Observable<String>.of("👧🏼", "👧🏻", "👦🏽")

classYellow
    .enumerated()
    .map { index, element in
        return element + "kid" + "\(index)"
    }
    .startWith("👨🏻teacher")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------concat1----------")
let kidsInClassYellow = Observable<String>.of("👧🏼", "👧🏻", "👦🏽")
let teacher = Observable<String>.of("👨🏻teacher")

let walkingInLine = Observable.concat([teacher, kidsInClassYellow])

walkingInLine
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------concat2----------")
teacher
    .concat(kidsInClassYellow)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------concatMap----------")
let daycareCenter: [String: Observable<String>] = [
    "classYellow": Observable.of("👧🏼", "👧🏻", "👦🏽"),
    "classBlue": Observable.of("👶🏾", "👶🏻")
]

Observable.of("classYellow", "classBlue")
    .concatMap { `class` in
        daycareCenter[`class`] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------merge1----------")
let northOfTheHan = Observable.from(["Gangbuk-gu", "Seongbuk-gu", "Dongdaemun-gu", "Jongro-gu"])
let southOfTheHan = Observable.from(["Gangnam-gu", "Gangdong-gu", "Youngdeungpo-gu", "Yangcheon-gu"])

Observable.of(northOfTheHan, southOfTheHan)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------merge2----------")
Observable.of(northOfTheHan, southOfTheHan)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------combineLatest1----------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest(lastName, firstName) { lastName, firstName in
    firstName + " " + lastName
}

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Bush")
firstName.onNext("George")
firstName.onNext("Barack")
firstName.onNext("Madeleine")
lastName.onNext("Obama")
lastName.onNext("Albright")
lastName.onNext("Clinton")

print("----------combineLatest2----------")
let dateDisplayFormat = Observable<DateFormatter.Style>.of(.short, .long)
let currentDate = Observable<Date>.of(Date())

let currentDayDisplay = Observable
    .combineLatest(dateDisplayFormat, currentDate) { format, date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = format
        return dateFormatter.string(from: date)
    }

currentDayDisplay
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------combineLatest3----------")
let lstName = PublishSubject<String>()
let fstName = PublishSubject<String>()

let fulName = Observable
    .combineLatest([fstName, lstName]) { name in
        name.joined(separator: " ")
    }

fulName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lstName.onNext("Kim")
fstName.onNext("Paul")
fstName.onNext("Stella")
fstName.onNext("Lily")

print("----------zip----------")
enum WinLose {
    case win
    case lose
}

let match = Observable<WinLose>.of(.win, .win, .lose, .win, .lose)
let player = Observable<String>.of("🇰🇷", "🇨🇭", "🇺🇸", "🇧🇷", "🇯🇵", "🇨🇳")

let result = Observable
    .zip(match, player) { result, representitive in
        return "player" + representitive + " \(result)"
    }

result
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------withLatestFrom1----------")
let 💥🔫 = PublishSubject<Void>()
let runner = PublishSubject<String>()

💥🔫
    .withLatestFrom(runner)
    .distinctUntilChanged() // gets to be the same as sample() with this operator
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

runner.onNext("🏃🏻‍♀️")
runner.onNext("🏃🏻‍♀️ 🏃‍♂️")
runner.onNext("🏃🏻‍♀️ 🏃‍♂️ 🏃🏼")
💥🔫.onNext(Void())
💥🔫.onNext(Void())

print("----------sample----------")
let 🏁start = PublishSubject<Void>()
let F1player = PublishSubject<String>()

F1player
    .sample(🏁start)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1player.onNext("🏎️")
F1player.onNext("🏎️   🚗")
F1player.onNext("🏎️      🚗   🚙")
🏁start.onNext(Void())
🏁start.onNext(Void())
🏁start.onNext(Void())

print("----------amb----------") // ambiguous
let 🚌bus1 = PublishSubject<String>()
let 🚌bus2 = PublishSubject<String>()

let 🚏busStop = 🚌bus1.amb(🚌bus2)

🚏busStop
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

🚌bus2.onNext("bus2-passenger0: 👩🏼")
🚌bus1.onNext("bus1-passenger0: 👨🏼‍⚕️")
🚌bus1.onNext("bus1-passenger1: 👨🏻‍⚕️")
🚌bus2.onNext("bus2-passenger1: 👩🏻‍💼")
🚌bus1.onNext("bus1-passenger1: 👩🏽‍⚕️")
🚌bus2.onNext("bus2-passenger2: 👩‍⚕️")

print("----------switchLatest----------")
let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let raiseHand = PublishSubject<Observable<String>>()

let classroomOnlyRaiseHand = raiseHand.switchLatest()

classroomOnlyRaiseHand
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

raiseHand.onNext(student1)
student1.onNext("student1: I am student1")
student2.onNext("student2: Here!!")

raiseHand.onNext(student2)
student2.onNext("student2: I am #2!")
student1.onNext("student1: Ugh.. I still have something to say..")

raiseHand.onNext(student3)
student2.onNext("student2: Wait! Let me!")
student1.onNext("student1: When can I say?")
student3.onNext("student3: I am #3! I think I won.")

raiseHand.onNext(student1)
student1.onNext("student1: You're wrong. The winner is me.")
student2.onNext("student2: ...")
student3.onNext("student3: I thought I won.")
student2.onNext("student2: Is this something about win or lose?")

print("----------reduce----------")
Observable.from(1...10)
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)









