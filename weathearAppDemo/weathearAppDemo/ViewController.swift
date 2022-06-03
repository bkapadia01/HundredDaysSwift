//
//  ViewController.swift
//  weathearAppDemo
//
//  Created by Bhavin Kapadia on 2022-05-22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var table: UITableView!
    
    var models = [Daily]()
    let locationManager  = CLLocationManager()
    var currenetLocation: CLLocation?
    var current: Current?
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        setupLocation()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register 2 Cells
        
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifer)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifer)
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    //Location
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currenetLocation == nil  {
            currenetLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    
    func requestWeatherForLocation() {
        guard let currenetLocation = currenetLocation else {
            return
        }

        let long: Int = Int(currenetLocation.coordinate.longitude)
        let lat: Int = Int(currenetLocation.coordinate.latitude)
        
        
//        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=f1266e7ef11b56cc3e6f353b3bb2c635"
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely,hourly,alerts&units=metric&appid=f1266e7ef11b56cc3e6f353b3bb2c635"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            // Validation
            guard let data = data, error == nil else {
                print("something's wrong with the data")
                return
            }
        
            // convert data to models/some object
            
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            } catch {
                print("error: \(error)")
            }
            
            guard let results = json else {
                return
            }
            let current = results.current
            self.current = current
//            print(results.daily[0].weather[0].main!)
            
            let entries = results.daily
            
            self.models.append(contentsOf: entries)

            
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
            }
            
        }).resume()

    }

    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        headerView.backgroundColor = UIColor(red: 52/255, green: 109/255, blue: 179/255, alpha: 1.0)
        
        let locationLabel =  UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: headerView.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20 + locationLabel.frame.size.height, width: view.frame.size.width - 20, height: headerView.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20 + summaryLabel.frame.size.height + locationLabel.frame.size.height, width: view.frame.size.width - 20, height: headerView.frame.size.height/2))

        
        headerView.addSubview(locationLabel)
        headerView.addSubview(summaryLabel)
        headerView.addSubview(tempLabel)

        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        tempLabel.textAlignment = .center

        
        guard let current = self.current else {
            return UIView()
        }

        tempLabel.text = "\(self.current!.temp)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        locationLabel.text = "Current Locaiton"
        summaryLabel.text = "\(self.current!.weather[0].main)°"
        return headerView
    }

    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifer, for: indexPath) as! WeatherTableViewCell
        cell.configureWithModel(with: models[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

