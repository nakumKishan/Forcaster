//
//  Constants.swift
//  Forecast
//
//  Created by Kishan nakum on 04/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import UIKit

let UK = "UK"
let england = "england"
let scotland = "scotland"
let wales = "wales"
var maxTemp = "Max Temp"
var minTemp = "Min Temp"
var meanTemp = "Mean Temp"
var sunshine = "Sunshine"
var rainfall = "Rainfall"
var currentYear = "2018"
let MyDownloadsCompleteNotification = "MyDownloadsCompleteNotification"
let MyExportCompleteNotification = "MyExportCompleteNotification"
var monthData = ["JAN" ,"FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","WIN","SPR","SUM","AUT","ANN"
]
let url = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/date/UK.txt")!
let url1 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/date/UK.txt")!
let url2 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/date/UK.txt")!
let url3 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/date/UK.txt")!
let url4 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/date/UK.txt")!


let url5 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/date/England.txt")!
let url6 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/date/England.txt")!
let url7 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/date/England.txt")!
let url8 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/date/England.txt")!
let url9 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/date/England.txt")!

let url10 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/date/Wales.txt")!
let url11 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/date/Wales.txt")!
let url12 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/date/Wales.txt")!
let url13 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/date/Wales.txt")!
let url14 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/date/Wales.txt")!

let url15 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/date/Scotland.txt")!
let url16 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/date/Scotland.txt")!
let url17 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/date/Scotland.txt")!
let url18 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/date/Scotland.txt")!
let url19 = URL(string:"https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/date/Scotland.txt")!


extension String {
    func inserting(separator: String, every n: Int) -> [String] {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        
        var columnArray = result.components(separatedBy: "$$")
        columnArray.count != 18 ? columnArray.append(contentsOf: repeatElement("", count: 2)) : nil
        return columnArray.map { $0.trimmingCharacters(in: .whitespaces) }
    }
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}
