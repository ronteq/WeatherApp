//
//  HomeWeatherCell.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class HomeWeatherCell: BaseCell{
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Clouds")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = UIColor.darkGray
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cloudy"
        return label
    }()
    
    private lazy var highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "76.5°"
        return label
    }()
    
    private lazy var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "65.4°"
        return label
    }()
    
    var forecast: Forecast?{
        didSet{
            dateLabel.text = forecast?.dateWithFormat
            weatherTypeLabel.text = forecast?.weatherType
            weatherImageView.image = UIImage(named: forecast!.weatherType)
            highTemperatureLabel.text = "\(forecast!.highTemp)°"
            lowTemperatureLabel.text = "\(forecast!.lowTemp)°"
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
        setupWeatherImageView()
        setupStackViews()
    }
    
    private func setupWeatherImageView(){
        addSubview(weatherImageView)
        addConstraintsToWeatherImageView()
    }
    
    private func addConstraintsToWeatherImageView(){
        weatherImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    private func setupStackViews(){
        let leftStackView = UIStackView(arrangedSubviews: [dateLabel, weatherTypeLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillEqually
        leftStackView.alignment = .fill
        
        let rightStackView = UIStackView(arrangedSubviews: [highTemperatureLabel, lowTemperatureLabel])
        rightStackView.axis = .vertical
        rightStackView.distribution = .fillEqually
        rightStackView.alignment = .fill
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        addConstraintsToStackView(stackView)
    }
    
    private func addConstraintsToStackView(_ stackView: UIStackView){
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
