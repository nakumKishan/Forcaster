//
//  DataParseManager.swift
//  Forecast
//
//  Created by Kishan nakum on 05/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation

class CsvDataModel{
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var year = ""
    var region = ""
    var dataType = ""
    var dataValue = ""
    var month = ""
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    init(year:String,region:String,dataType:String,dataValue:String,month:String) {
        self.dataType = dataType
        self.dataValue = dataValue
        self.month = month
        self.region = region
        self.year = year
    }
}

func parseData(fileData:[String],region:String,datatype:String,calanderData:[String]){
    for (index,data) in calanderData.enumerated(){
        if index != 0{
            if fileData[0] == currentYear && index > 6{
            writeDataForCurrentYear(index: index, fileData: fileData, region: region, datatype: datatype, calanderData: calanderData)
            }else{
                var dataToWrite = fileData[index]
                if fileData[index].contains("---") {
                    dataToWrite = "N/A"
                }
            let csvData = CsvDataModel(year: fileData[0], region: region, dataType: datatype, dataValue:dataToWrite, month:String(data.filter { !"\r".contains($0) }))
          DownloadManager.sharedInstance.allCsvData.append(csvData)
            }
            }
        }
    }

func writeDataForCurrentYear(index:Int,fileData:[String],region:String,datatype:String,calanderData:[String]){
    switch index {
    case 7,8,9,10,11,12,15,16,17:
        let csvData = CsvDataModel(year: fileData[0], region: region, dataType: datatype, dataValue:"N/A", month:String(calanderData[index].filter { !"\r".contains($0) }))
        DownloadManager.sharedInstance.allCsvData.append(csvData)
        break
    case 13,14:
        let csvData = CsvDataModel(year: fileData[0], region: region, dataType: datatype, dataValue:fileData[(index-1)-5], month:String(calanderData[index].filter { !"\r".contains($0) }))
        DownloadManager.sharedInstance.allCsvData.append(csvData)
        break
    default:
    print("")
    }
}
