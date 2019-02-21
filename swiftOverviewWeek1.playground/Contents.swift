import UIKit

/*
 Multi-line comment
 
 Variables
 Functions
 Optionals
 */

// Single-line comment

var variableInt: Int = 5 // Explicit type declaration
var variableInt2 = 5 // Inferred type

print(variableInt)

// arrays and dictionaries

// [1,2,3,4,5]
/*
 
 {
    firstKey: 1,
    secondKey: 2,
    thirdKey: 3
 }
 
 */

var someArray: [String] = []
var anotherArray = [String]()

var someDictionary: [String: Any] = [:]
var anotherDictionary = [String: Any]()
anotherDictionary["someKey"] = 5

print(anotherDictionary)

// String-interpolation

var name = "Matt"
print(name + " Rodriguez")
print("My name is \(name) Rodriguez")

/****** FUNCTIONS ******/

func printHello() -> Void {
    print("Hello")
}
printHello()

func printMyFavoriteFood(food: String, drink: String) {
    print("Favorite food: \(food)")
    print("Favorite drink: \(drink)")
}
printMyFavoriteFood(food: "pizza", drink: "coffee")

// External parameter names
// Internal parameter names

func printDoubleOfSomeNum(externalParameter internalParameter: Int) {
    print(internalParameter * 2)
}
printDoubleOfSomeNum(externalParameter: 5)

// Return types
func doubleThisNum(input: Int) -> Int {
    return input * 2
}
var x = doubleThisNum(input: 10)
print(x)

/******* OPTIONALS *******/

// return nil


func getBioData(input: String) -> String? {
    if input == "firstName" {
        return "Matt"
    } else if input == "lastName" {
        return "Rodriguez"
    } else {
        return nil
    }
}

var info: String? = getBioData(input: "aefhluagseflsagef")

// unwrapping optional values

if let unwrappedInfo = info {
    // checks if value in info is != nil
    print(unwrappedInfo)
} else {
    print("value found was nil")
}

print(info!) //force unwrapping

// https://www.hackingwithswift.com/read/0/overview
