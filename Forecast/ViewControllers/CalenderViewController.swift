//
//  CalenderViewController.swift
//  Forecast
//
//  Created by Kishan nakum on 05/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var regionYearData = [CsvDataModel]()
    var selectedRegion =  ""
    var selectedYear =  ""
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        print(DownloadManager.sharedInstance.allCsvData.count)
        _ = DownloadManager.sharedInstance.allCsvData.map{
            if $0.year.contains(selectedYear) && $0.region.contains(selectedRegion){
                regionYearData.append($0)
            }
        }
    }
    
    func setupCollectionView() {
        if let flowLayout = calenderCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing =  0
        }
        calenderCollectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        calenderCollectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    }

    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

/* ==========================================================================
 // MARK: Extension : UICollectionView
 ========================================================================== */
extension CalenderViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calenderCell", for: indexPath) as! CalenderCollectionCell
        cell.calenderLabel.text = monthData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = regionYearData.filter{
            if $0.month == monthData[indexPath.row]{
                return true
            }
            return false
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let control = storyBoard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        control?.weatherData = data
        control?.selectedYear = selectedYear
        control?.selectedMonth = monthData[indexPath.row]
        self.navigationController?.pushViewController(control!, animated: true)
        print(data)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.calenderCollectionView.frame.width/2)-10, height:135)
    }
}
