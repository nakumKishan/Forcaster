//
//  WeatherViewControllerTableViewController.swift
//  Forecast
//
//  Created by Kishan nakum on 03/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class WeatherViewController:UIViewController{

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var weatherSegment: UISegmentedControl!
    @IBOutlet weak var customNavigationView: UIView!
    @IBOutlet weak var weatherIconView: SKYIconView!
    @IBOutlet weak var weatherValueLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var weatherData = [CsvDataModel]()
    var selectedMonth =  ""
    var selectedYear =  ""
    
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = "\(selectedMonth),\(selectedYear)"
        weatherIconView.setType = .clearDay
        weatherIconView.setColor = UIColor.white
        weatherIconView.play()
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        setupCollectionView()
        weatherValueLabel.text = getWeatherValue(weatherType:"Max Temp")
        customNavigationView.backgroundColor = UIImage(named: "MaxTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
    }
    
    /* ==========================================================================
     // MARK: Custom initialization + setup methods
     ========================================================================== */
    func setupCollectionView() {
        if let flowLayout = weatherCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        weatherCollectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        weatherCollectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        weatherCollectionView?.isPagingEnabled = true
    }
  
    func getWeatherValue(weatherType:String) -> String{
        var valueStr = "N/A"
        _ = self.weatherData.map{
            if $0.dataType == weatherType{
                valueStr = $0.dataValue
            }
        }
        return valueStr
    }

    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func segmentClicked(_ sender: Any) {
        switch weatherSegment.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .clearDay
            }
            scrollToMenuIndex(menuIndex: 0)
            weatherValueLabel.text = getWeatherValue(weatherType:"Max Temp")
            customNavigationView.backgroundColor = UIImage(named: "MaxTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 1:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .cloudy
            }
            scrollToMenuIndex(menuIndex: 1)
            weatherValueLabel.text = getWeatherValue(weatherType:"Min Temp")
            customNavigationView.backgroundColor = UIImage(named: "MinTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 2:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .partlyCloudyDay
            }
            scrollToMenuIndex(menuIndex: 2)
            weatherValueLabel.text = getWeatherValue(weatherType:"Mean Temp")
            customNavigationView.backgroundColor = UIImage(named: "MeanTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 3:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .sleet
            }
            scrollToMenuIndex(menuIndex: 3)
            weatherValueLabel.text = getWeatherValue(weatherType:"Sunshine")
            customNavigationView.backgroundColor = UIImage(named: "Sunshine")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 4:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .rain
            }
            scrollToMenuIndex(menuIndex: 4)
            weatherValueLabel.text = getWeatherValue(weatherType:"Rainfall")
            customNavigationView.backgroundColor = UIImage(named: "Rainfall")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        default:
            print("")
        }
    }
    
}

/* ==========================================================================
 // MARK: Extension : UICollectionView
 ========================================================================== */
extension WeatherViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.weatherBackgroundImage.image = UIImage(named: "MaxTemp")
            break
        case 1:
            cell.weatherBackgroundImage.image = UIImage(named: "MinTemp")
            break
        case 2:
            cell.weatherBackgroundImage.image = UIImage(named: "MeanTemp")
            break
        case 3:
            cell.weatherBackgroundImage.image = UIImage(named: "Sunshine")
            break
        case 4:
            cell.weatherBackgroundImage.image = UIImage(named: "Rainfall")
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: ( self.weatherCollectionView.frame.height))
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        weatherCollectionView.reloadData()
        weatherCollectionView.scrollToItem(at: indexPath , at: [], animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .clearDay
            }
            
            weatherSegment.selectedSegmentIndex = 0
            weatherValueLabel.text = getWeatherValue(weatherType:"Max Temp")
            customNavigationView.backgroundColor = UIImage(named: "MaxTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 1:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .cloudy
            }
            weatherSegment.selectedSegmentIndex = 1
            weatherValueLabel.text = getWeatherValue(weatherType:"Min Temp")
            customNavigationView.backgroundColor = UIImage(named: "MinTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 2:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .partlyCloudyDay
            }
            weatherSegment.selectedSegmentIndex = 2
            weatherValueLabel.text = getWeatherValue(weatherType:"Mean Temp")
            customNavigationView.backgroundColor = UIImage(named: "MeanTemp")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 3:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .sleet
            }
                weatherSegment.selectedSegmentIndex = 3
            weatherValueLabel.text = getWeatherValue(weatherType:"Sunshine")
            customNavigationView.backgroundColor = UIImage(named: "Sunshine")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        case 4:
            UIView.animate(withDuration: 2) {
                self.weatherIconView.setType = .rain
            }
                        weatherSegment.selectedSegmentIndex = 4
            weatherValueLabel.text = getWeatherValue(weatherType:"Rainfall" )
            customNavigationView.backgroundColor = UIImage(named: "Rainfall")?.getPixelColor(pos: CGPoint(x: 50, y: 50))
            break
        default:
            print("")
        }
        segmentClicked(self)
    }

    }

