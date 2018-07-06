//
//  YearListViewController.swift
//  Forecast
//
//  Created by Kishan nakum on 03/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class YearListViewController: UIViewController {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var yearTableView: UITableView!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var dic = [String:String]()
    var dicArray = [String]()
    var selectedRegion =  ""
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
       _ = DownloadManager.sharedInstance.allCsvData.map{
            dic[$0.year] = $0.year
        }
        dicArray = Array(dic.keys)
        dicArray.sort { Int($0)! < Int($1)! }
        yearTableView.delegate = self
        yearTableView.dataSource = self
    }
    
    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

/* ==========================================================================
 // MARK: Extension : UITableView
 ========================================================================== */
extension YearListViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yearCell", for: indexPath) as! YearTableViewCell
        cell.yearLabel.text = dicArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let control = storyBoard.instantiateViewController(withIdentifier: "CalenderViewController") as? CalenderViewController
        control?.selectedRegion = self.selectedRegion
        control?.selectedYear = dicArray[indexPath.row]
        self.navigationController?.pushViewController(control!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
