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
