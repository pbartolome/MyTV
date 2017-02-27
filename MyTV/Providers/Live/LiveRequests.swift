//
//  LiveRequests.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

struct LiveURL {
    static let url = "https://mytv-api.s3.amazonaws.com/liveTV.json"
}

struct LiveRequests {

    static func liveChannels(completion: @escaping (LiveAPI.LiveSection) -> Void) {
        Alamofire.request(LiveURL.url).responseJSON { response in

            if let JSON = response.result.value as? UnboxableDictionary {
                let channels: LiveAPI.LiveSection = try! unbox(dictionary: JSON)
                completion(channels)
            }

        }
    }

}
