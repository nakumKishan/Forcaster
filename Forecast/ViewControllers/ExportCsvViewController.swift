//
//  ExportCsvViewController.swift
//  Forecast
//
//  Created by Kishan nakum on 06/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class ExportCsvViewController: UIViewController {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var imageLoader: UIImageView!
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoader.rotate360Degrees()
        NotificationCenter.default.addObserver(self, selector: #selector(exportComplete(notification:)), name: NSNotification.Name(rawValue: MyExportCompleteNotification), object: nil)
    }

    @objc func exportComplete(notification:Notification)
    {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

/* ==========================================================================
 // MARK: Extension:UIView
 ========================================================================== */
extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
