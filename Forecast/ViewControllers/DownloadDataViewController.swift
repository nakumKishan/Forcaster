//
//  DownloadDataViewController.swift
//  Forecast
//
//  Created by Kishan nakum on 04/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class DownloadDataViewController: UIViewController {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var exploreDataButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ukDownloadImage: UIImageView!
    @IBOutlet weak var englandDownloadImage: UIImageView!
    @IBOutlet weak var downloadInfoLabel: UILabel!
    @IBOutlet weak var walesDownloadImage: UIImageView!
    @IBOutlet weak var scotlandDownloadImage: UIImageView!
    @IBOutlet weak var ukDetailLabel: UILabel!
    @IBOutlet weak var englandDetailLabel: UILabel!
    @IBOutlet weak var walesDetailLabel: UILabel!
    @IBOutlet weak var scotlandDetailLabel: UILabel!
    @IBOutlet weak var ukFlagImage: UIImageView!
    @IBOutlet weak var englandFlagImage: UIImageView!
    @IBOutlet weak var walesFlagImage: UIImageView!
    @IBOutlet weak var scotlandFlagImage: UIImageView!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var englandData = [url5,url6,url7,url8,url9]
    var ukData = [url,url1,url2,url3,url4]
    var scotlandData = [url15,url16,url17,url18,url19]
    var walesData = [url10,url11,url12,url13,url14]
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        if isNetworkAvailable(){
            DownloadManager.sharedInstance.downloadData(data: ukData, forRegion: UK)
        }else{
            let alert = UIAlertController(title: "No Internet Connection", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(allDownloadsComplete), name: NSNotification.Name(rawValue: MyDownloadsCompleteNotification), object: nil)
    }
    
    func setupView(){
        exploreDataButton.isHidden = true
        ukDownloadImage.isHidden = true
        englandDownloadImage.isHidden = true
        scotlandDownloadImage.isHidden = true
        walesDownloadImage.isHidden = true
        ukDownloadImage.alpha = 0.1
        englandDownloadImage.alpha = 0.1
        scotlandDownloadImage.alpha = 0.1
        walesDownloadImage.alpha = 0.1
        ukFlagImage.alpha = 0.3
        ukDetailLabel.alpha = 0.3
        englandDetailLabel.alpha = 0.3
        englandFlagImage.alpha = 0.3
        scotlandDetailLabel.alpha = 0.3
        scotlandFlagImage.alpha = 0.3
        walesFlagImage.alpha = 0.3
        walesDetailLabel.alpha = 0.3
    }
    
    @objc func allDownloadsComplete(notification:Notification)
    {
        switch notification.object as! String {
        case UK:
            DownloadManager.sharedInstance.downloadData(data: englandData, forRegion: england)
            downloadCompleteForRegion(flagImage: ukFlagImage, detailText: ukDetailLabel, downloadImage: ukDownloadImage, region: UK)
            break
        case england:
            DownloadManager.sharedInstance.downloadData(data: walesData, forRegion: wales)
            downloadCompleteForRegion(flagImage: englandFlagImage, detailText: englandDetailLabel, downloadImage: englandDownloadImage, region: england)
            break
        case wales:
            DownloadManager.sharedInstance.downloadData(data: scotlandData, forRegion: scotland)
            downloadCompleteForRegion(flagImage: walesFlagImage, detailText: walesDetailLabel, downloadImage: walesDownloadImage, region: wales)
            break
        case scotland:
            downloadCompleteForRegion(flagImage: scotlandFlagImage, detailText: scotlandDetailLabel, downloadImage: scotlandDownloadImage, region: scotland)
            break
        default:
            print("No case exist")
        }
        print("Awesome all downloads are done!")
    }

    func downloadCompleteForRegion(flagImage:UIImageView,detailText:UILabel,downloadImage:UIImageView,region:String){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 2.0, animations: {
                flagImage.alpha = 1.0
                detailText.alpha = 1.0
                downloadImage.isHidden = false
            }, completion: { (bool) in
                downloadImage.alpha = 1.0
                if region == scotland{
                    DispatchQueue.main.async {
                        self.downloadInfoLabel.text = "Download complete for all region."
                        self.activityIndicator.stopAnimating()
                        self.exploreDataButton.isHidden = false
                        print("\(DownloadManager.sharedInstance.allCsvData[233].month)")
                    }
                }
            })
        }
    }
    
    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func exploreDataButtonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let control = storyBoard.instantiateViewController(withIdentifier: "RegionViewController") as? RegionViewController
        self.navigationController?.pushViewController(control!, animated: true)
    }
}
