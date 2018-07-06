//
//  DownloadManager.swift
//  Forecast
//
//  Created by Kishan nakum on 04/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import UIKit

class DownloadManager{

    class var sharedInstance: DownloadManager {
        struct Singleton {
            static let instance = DownloadManager()
        }
        return Singleton.instance
    }

    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var allCsvData = [CsvDataModel]()
    let fileName = "weather.csv"
    var csvText = "region_code,weather_param,year, key, value\n"
    var pathurl : URL?
    let session = URLSession.shared
    let lockQueue = DispatchQueue(label: "com.dsdevelop.lockQueue")
    var myLinks:[NSURL]?
    var downloadQueue:[NSURL]?

    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    init() {
    }
    
    func downloadData(data:[URL],forRegion:String){
        downloadAllLinks(links: data as [NSURL], forRegion: forRegion)
    }
    
    
    func getRemainingActiveDownloads() -> Int
    {
        return (self.downloadQueue != nil) ? self.downloadQueue!.count : 0
    }
    
    func removeUrlFromDownloadQueue(url:NSURL)
    {
        if self.downloadQueue != nil
        {
            lockQueue.sync() {
                self.downloadQueue = self.downloadQueue!.filter({$0.absoluteString == url.absoluteString})
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            print("\(Int(percentage * 100))%")
        }
    }
    
    func downloadAllLinks(links:[NSURL],forRegion:String)
    {
        // suspending queue so they don't all finish before we can show it
        session.delegateQueue.isSuspended = true
        session.delegateQueue.maxConcurrentOperationCount = 1
        downloadQueue = links
        
        // create tasks
        for (index,link) in links.enumerated()
        {
            var dataType = ""
            switch index{
            case 0:
                dataType = maxTemp
                break
            case 1:
                dataType = minTemp
                break
            case 2:
                dataType = meanTemp
                break
            case 3:
                dataType = sunshine
                break
            case 4:
                dataType = rainfall
                break
            default:
                print("")
            }
            let dltask = self.session.dataTask(with:link as URL) { (data, response, error) in
                if let urlString = response?.url?.absoluteString
                {
                    self.downloadQueue = self.downloadQueue!.filter({$0.absoluteString != urlString})
                    let remaining = self.getRemainingActiveDownloads()
                    print("Downloaded.  Remaining: \(remaining)")
                    if error != nil {
                        print(error!)
                    }
                    else {
//                        print(response)
                        if let textFile = String(data: data!, encoding: .utf8) {
                            let readings  = textFile.components(separatedBy: "\n")
                            let newArray = Array(readings.dropFirst(7))
                            print(newArray[0])
                            var calenderData = [String]()
                            for i in 0...newArray.count-2{
                                let strArray = self.cleanTabsAndSpace(in: newArray[i])
                                let finalArray = strArray.components(separatedBy: " ")
                                let datastr = newArray[i].inserting(separator: "$$", every: 7)
                                if i == 0{
                                    calenderData = datastr
                                }else{
                                    parseData(fileData: finalArray, region: forRegion, datatype:dataType, calanderData: calenderData)
                                    if i == newArray.count-2{
                                        if (remaining == 0)
                                        {
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: MyDownloadsCompleteNotification), object: forRegion)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            print("Queuing task \(dltask)")
            dltask.resume()
        }
        
        // resuming queue so all tasks run
        session.delegateQueue.isSuspended = false
    }

    func writeCsv(viewController:UIViewController){
        pathurl = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        print(DownloadManager.sharedInstance.allCsvData.count)
        DispatchQueue.main.async {
            for (index,task) in DownloadManager.sharedInstance.allCsvData.enumerated() {
                let newLine = "\(task.region),\(task.dataType),\(task.year),\(task.month),\(task.dataValue)\n"
                print(newLine)
                self.csvText.append(newLine)
                if index == DownloadManager.sharedInstance.allCsvData.count-1{
                    print(self.csvText)
                    self.exportCsv(path: self.pathurl!, viewController: viewController)
                }
            }
        }
    }
    
    func cleanTabsAndSpace(in text:String) -> String {
        var newText = text
        newText = newText.filter{ $0 != "\t" }.reduce(""){ str, char in
            if let lastChar = str.last, lastChar == " " && lastChar == char {
                return str
            }
            return str + String(char)
        }
        return newText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func exportCsv(path:URL,viewController:UIViewController){
        do {
            try csvText.write(to: pathurl!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MyExportCompleteNotification), object: nil)

        print(DownloadManager.sharedInstance.allCsvData.count)
        let vc = UIActivityViewController(activityItems: [path], applicationActivities:[])
        DispatchQueue.main.async {
            viewController.present(vc, animated: true, completion: nil)
        }
    }

}

