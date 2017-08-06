//
//  HomeWeatherVC.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/10/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit
import CoreLocation

class HomeWeatherVC: UIViewController{
    
    fileprivate let cellId = "cellId"
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 81/255, green: 164/255, blue: 255/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textColor = UIColor.white
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 64)
        label.textColor = UIColor.white
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textColor = UIColor.white
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeWeatherCell.self, forCellReuseIdentifier: self.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startMonitoringSignificantLocationChanges()
        return manager
    }()
    
    fileprivate var currentLocation: CLLocation? {
        didSet{
            fetchCurrentWeather()
            fetchForecast()
        }
    }
    
    fileprivate var currentWeather: Weather? {
        didSet{
            locationLabel.text = currentWeather?.cityName
            weatherTypeLabel.text = currentWeather?.weatherType
            weatherImageView.image = UIImage(named: (currentWeather?.weatherType)!)
            dateLabel.text = currentWeather?.dateWithFormat
            temperatureLabel.text = "\(currentWeather!.currentTemperature)°"
        }
    }
    
    fileprivate var forecasts: [Forecast]?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    //MARK: Fetch data from APIs
    
    private func fetchCurrentWeather(){
        Weather.getWeatherByLocation(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude) { (weather) in
            DispatchQueue.main.async {
                self.currentWeather = weather
            }
        }
    }
    
    private func fetchForecast(){
        Forecast.getForecastByLocation(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude) { (forecasts) in
            DispatchQueue.main.async {
                self.forecasts = forecasts
            }
        }
    }
    
    //MARK: Setup views
    
    private func setupViews(){
        view.addSubview(headerView)
        headerView.addSubview(dateLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(locationLabel)
        headerView.addSubview(weatherImageView)
        headerView.addSubview(weatherTypeLabel)
        
        view.addSubview(tableView)
        
        addConstraintsToHeaderView()
        addViewsIntoStackview()
        addConstraintsToTableView()
    }
    
    private func addConstraintsToHeaderView(){
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func addViewsIntoStackview(){
        let leftStackView = UIStackView(arrangedSubviews: [dateLabel, temperatureLabel, locationLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillEqually
        leftStackView.alignment = .fill
        
        let rightStackView = UIStackView(arrangedSubviews: [weatherImageView, weatherTypeLabel])
        rightStackView.axis = .vertical
        rightStackView.distribution = .equalCentering
        rightStackView.alignment = .center
        rightStackView.spacing = 20
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        addConstraintsToStackView(stackView)
    }
    
    private func addConstraintsToStackView(_ stackView: UIStackView){
        stackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func addConstraintsToTableView(){
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: Tableview methods

extension HomeWeatherVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = forecasts?.count{
            return count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeWeatherCell
        
        if let forecast = forecasts?[indexPath.row]{
            cell.forecast = forecast
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: Location Manager methods

extension HomeWeatherVC: CLLocationManagerDelegate{
    
    fileprivate func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

}







