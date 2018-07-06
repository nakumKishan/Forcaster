//
//  ViewController.swift
//  Forecast
//
//  Created by Kishan nakum on 28/06/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class RegionViewController: UIViewController {
    
    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var downloadButton: UIButton!
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        regionCollectionView.isScrollEnabled = false
        regionCollectionView.delegate = self
        regionCollectionView.dataSource = self
    }
    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */

    @IBAction func btnClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let control = storyBoard.instantiateViewController(withIdentifier: "ExportCsvViewController") as? ExportCsvViewController
        DispatchQueue.main.async {
            self.present(control!, animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            DownloadManager.sharedInstance.writeCsv(viewController: self)
        }
    }
}

/* ==========================================================================
 // MARK: Extension : UICollectionView
 ========================================================================== */

extension RegionViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "regionCell", for: indexPath) as! RegionCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.regionLabel.text = UK
            cell.regionFlag.image = UIImage(named: "united-kingdom")
            break
        case 1:
            cell.regionLabel.text = england
            cell.regionFlag.image = UIImage(named: "england")
            break
        case 2:
            cell.regionLabel.text = wales
            cell.regionFlag.image = UIImage(named: "wales")
            break
        case 3:
            cell.regionLabel.text = scotland
            cell.regionFlag.image = UIImage(named: "scotland")
            break
        default:
            print("")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RegionCollectionViewCell
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let control = storyBoard.instantiateViewController(withIdentifier: "YearListViewController") as? YearListViewController
        control?.selectedRegion = cell.regionLabel.text!
        self.navigationController?.pushViewController(control!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height:110)
    }
}

