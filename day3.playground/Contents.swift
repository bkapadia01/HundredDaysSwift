import UIKit

var str = "Hello, playground"

let meanOFLifee = 43
let doubleMeaning = 43 + 43

let fake = "fakes"
let action = fake + "punch"

let firstarr = ["ab", "ac"]
let secondarr = ["ad", "ae"]
let arrcombine = firstarr + secondarr

var score = 95
score -= 5
score += 5

var quotes = "the rain falls"
quotes += "today"

let firstScore = 6
let secondScore = 4

firstScore  == secondScore
firstScore != secondScore

firstScore < secondScore

"taylor" <= "aylor"

let firstCard = 1
let secondCard = 1

if firstCard + secondCard == 2 {
    print("Ace is lucky")
} else if firstCard + secondCard == 21 {
    print("Black jack")
} else {
    print("regular card")
}

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("one of them is oldere")
}

let firstC = 11
let secondC = 10

print(firstC == secondC ? "cards are the same" : "cards are different")

let weather = "sunny"

switch weather {
case "rain":
    print("umbrella")
case "snow":
    print("bring jacket")
case "sunny":
    print("great")
    fallthrough
default:
    print("Enjoy your day")
}

let scorez = 85

switch scorez {
case 0..<50:
    print("bad")
case 50..<100:
    print("great")
default:
    "no grade"
}
