//
//  OHTTPHelpers.swift
//  MyTV
//
//  Created by Pablo Bartolome on 3/1/17.
//  Copyright © 2017 PB. All rights reserved.
//

import OHHTTPStubs

extension OHHTTPStubs {

    public static func blockAllServiceCalls() {
        stub(condition: { _ in return true }) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
    }

}

