//
//  ViewController.swift
//  tb-dev-project2-weatherapp
//
//  Created by Bhavin Kapadia on 2022-05-09.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(from: url)
    }

}

private func getData(from url: String) {
    let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            print("something went wrong")
            return
        }
        
        var results: Response?
        
        do {
            results = try JSONDecoder().decode(Response.self, from: data)
        } catch {
            print("faild to convert \(error.localizedDescription)")
            print(String(describing: error))
        }
        
        guard let json = results else {
            return
        }
        
        print(json.id!)
        print(json.base!)
        print(json.coord!)
        print(json.clouds!)
        print(json.dt!)
        print(json.weather!)
        print(json.main!)


    })
        task.resume()
}

let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=f1266e7ef11b56cc3e6f353b3bb2c635"
// token hardcode is fine, create class

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let response = try? newJSONDecoder().decode(Response.self, from: jsonData)


// MARK: - Response
struct Response: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Int?
    let lat: Int?
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
