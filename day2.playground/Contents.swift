import UIKit

var str = "Hello, playground"

let john = "John Lennon"
let paul = "Paul Mac"
let george = "George Har"

let beatles: [String] = [john, paul, george]
beatles[2]

let colors = Set(["red", "greeen", "blue"])

let colors2 = Set(["red", "green", "blue", "red" ])

var name = (first: "Taylor", last: "Swift")

name.0
name.first
name.first = "justin"

let address = (house: 555, street: "Taylor Swift Ave", city: "Nashville") // Tuple

address.house

let set = Set(["ard", "art", "ads"])
let python = ["Eric", "John", "Terry"]
python[1]

let height = [
    "taylor": 1.78,
    "sheeran": 1.73,
    "mick": 1.22
]
height["sheeran"]


let favIceCream = [
    "paul": "chocolate",
    "mark": "vanilla"
]

favIceCream["paul"]
favIceCream["charles", default: "Unknown"]

var team = [String: String]()
team["Paul"] = "red"

var results = [Int]()

var words = Set<String>()

var scores = Dictionary<String, Int>()

let result = "failure"
let result2 = "failed"

enum Result {
    case success
    case failure
}

let Resul4 = Result.failure

enum Activities {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activities.talking(topic: "football")


enum Planet: Int {
    case mercury = 2
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)

let albums = ["Prince": "Purple Rain"]
let beatlez = albums["Prince"]
var teams = [String: String]()
teams["paul"] = "red"
teams
var resultz = [Int]()
resultz = [1, 3]
resultz = [4]
resultz

var wordz = Set<String>()
var numbersz = Set<Int>()

var scoresa = Dictionary<String, Int>()
var resultsa = Array<Int>()

let results1 = "failure"
let results2 = "failed"
let resultd3 = "fasle"

enum Results {
    case success
    case failure

}

let result5 = Results.success

enum Actives {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let act = Actives.bored
let talkings = Actives.talking(topic: "football")

enum Planetz: Int {
    case mercury = 1
    case venus
    case mars
}

let earthz = Planetz(rawValue: 2)
