//
//  Reachability.swift
//  Travel App
//
//  Created by Kishan Nakum.
//

import Foundation
import SystemConfiguration

func isNetworkAvailable() -> Bool {
        var zeroAddr = sockaddr_in(sin_len: 0,
                                   sin_family: 0,
                                   sin_port: 0,
                                   sin_addr: in_addr(s_addr: 0),
                                   sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddr.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddr))
        zeroAddr.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var barrier: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &barrier) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isAvailable = (barrier.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let requiredConnection = (barrier.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let result = (isAvailable && !requiredConnection)
        return result
    }
