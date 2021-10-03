//
//  main.swift
//  Properties
//
//  Created by 2lup on 02.10.2021.
//

import Foundation

print("Hello, World!")


//MARK: Свойства хранения
print("\n//Свойства хранения")

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
print(rangeOfThreeItems.firstValue, rangeOfThreeItems.length)

rangeOfThreeItems.firstValue = 6
print(rangeOfThreeItems.firstValue, rangeOfThreeItems.length)


//MARK: Свойства хранения постоянных экземпляров структуры
print("\n//Свойства хранения постоянных экземпляров структуры")

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6 //ERROR, так как let rangeOfFourItems
print(rangeOfFourItems.firstValue, rangeOfFourItems.length)


//MARK: Ленивые свойства хранения
print("\n//Ленивые свойства хранения")

class DataImporter {
    /*
     DataImporter - класс для импорта данных из внешних источников
     Считаем, что классу требуется большое количество времени для инициализации
     */
    var fileName = "data.txt"
    // класс DataImporter функционал данных будет описан тут
}
 
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // класс DataManager обеспечит необходимую функциональность тут
}
 
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// экземпляр класса DataImporter для свойства importer еще не создано

print(manager.data)


//MARK: Вычисляемые свойства
print("\n//Вычисляемые свойства")

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center
print(initialSquareCenter)

square.center = Point(x: 15.0, y: 15.0)
print(square.origin)


//MARK: Сокращенный вариант объявления сеттера
print("\n//Сокращенный вариант объявления сеттера")

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


//MARK: Сокращенный вариант объявления геттера
print("\n//Сокращенный вариант объявления геттера")

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


//MARK: Вычисляемые свойства только для чтения
print("\n//Вычисляемые свойства только для чтения")

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print(fourByFiveByTwo.volume)


//MARK: Наблюдатели свойства
print("\n//Наблюдатели свойства")

class StepCounter {
    var totalStep: Int = 0 {
        willSet (newValue1) {
            print("willSet: \(newValue1)")
        }
        didSet {
            print("didSet: \(oldValue) ")
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalStep = 10
stepCounter.totalStep = 40

//Если передать свойство, имеющее наблюдателей, в функцию в качестве сквозного параметра, то наблюдатели willSet и didSet всегда вызываются
func someFunction(numberA: inout Int) {
    print("numberA = \(numberA * 10)")
}

someFunction(numberA: &stepCounter.totalStep)


//MARK: Обертки для свойств
print("\n//Обертки для свойств")

@propertyWrapper struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

//struct SmallRectangle {
//    private var _height = TwelveOrLess()
//    private var _width = TwelveOrLess()
//    var height: Int {
//        get { return _height.wrappedValue }
//        set { _height.wrappedValue = newValue }
//    }
//    var width: Int {
//        get { return _width.wrappedValue }
//        set { _width.wrappedValue = newValue }
//    }
//}

var rectangle = SmallRectangle()
print(rectangle.height)
// Выведет "0"

rectangle.height = 10
print(rectangle.height)
// Выведет "10"

rectangle.height = 24
print(rectangle.height)
// Выведет "12"


//MARK: Установка исходных значений для оберток свойств
print("\n//Установка исходных значений для оберток свойств")

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Выведет "0 0"

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Выведет "1 1"

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Выведет "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Выведет "5 4"

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Выведет "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
// Выведет "12"


//MARK: Проецирование значения из обертки свойства
print("\n//Проецирование значения из обертки свойства")

@propertyWrapper
struct SmallNumber1 {
    private var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}
struct SomeStructure {
    @SmallNumber1 var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Выведет "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)
// Выведет "true"

//----

@propertyWrapper struct someStruct1 {
    private var minimum: Int
    private var number: Int
    var projectedValue: String = "_"
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue >= minimum {
                number = newValue
                projectedValue = "newValue"
            } else {
                number = minimum
                projectedValue = "minimum"
            }
        }
    }
    
    init() {
        minimum = 1
        number = 1
    }
    
    init(wrappedValue: Int) {
        minimum = 1
        number = max(wrappedValue, minimum)
    }
    
    init(wrappedValue: Int, minimum: Int) {
        self.minimum = minimum
        number = max(wrappedValue, minimum)
    }
}

struct someStruct2 {
    @someStruct1 var a: Int
    @someStruct1 var b: Int = 2
    @someStruct1(wrappedValue: 2, minimum: 5) var c: Int
    @someStruct1(wrappedValue: 2) var d: Int
}

var some1 = someStruct2()

print(some1.a, some1.b, some1.c, some1.d)

some1.a = 10
print(some1.a, some1.b, some1.c, some1.d)

some1.b = 10
print(some1.a, some1.b, some1.c, some1.d)

some1.c = 0
print(some1.$a, some1.$b, some1.$c, some1.$d)


