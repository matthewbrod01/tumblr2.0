import UIKit

/***** VARIABLES *****/
var variableInt: Int = 5
let constantInt: Int = 5

var inferredType = "someString"
print(inferredType)

var someArray: [String] = []
var anotherArray = [String]()

var someDictionary: [String: Any] = [:]
var anotherDictionary = [String: Any]()
anotherDictionary["someKey"] = 5

var name = "Matt"
print("My name is \(name)") // String interpolation -- can handle different data types

/***** FUNCTIONS *****/

func printHello() {
    // basic function
    print("Hello")
}
printHello()


func printMyFavoriteFood(food: String, drink: String) {
    // function that takes parameters
    print("Favorite food: \(food)")         // string interpolation
    print("Favorite drink: \(drink)")
}
printMyFavoriteFood(food: "pizza", drink: "Coffee")


func printDoubleOfMyNum(externalVar internalVar: Int) {    // -> Void
    // external and internal parameter names
    print(internalVar * 2)
}
printDoubleOfMyNum(externalVar: 5)

func doubleThisNum(input: Int) -> Int {
    // functions with return types
    return input * 2
}

var x = doubleThisNum(input: 20)
print(x)



/***** OPTIONALS *****/

func getBioData(input: String) -> String? {
    // returns an OPTIONAL string
    if input == "firstName" {
        return "Matt"
    } else if input == "lastName" {
        return "Rodriguez"
    } else if input == "age" {
        return "22"
    }
    
    return nil
}

var info: String? = getBioData(input: "firstName")

if let unwrappedInfo = info {
    // unwraps, this code block only runs if info is != nil
    print(unwrappedInfo)
} else {
    print("Value was nil")
}

print(info!) // force unwrapping
