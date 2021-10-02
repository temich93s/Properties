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
