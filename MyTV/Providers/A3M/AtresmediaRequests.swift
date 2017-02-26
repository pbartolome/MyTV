//
//  AtresmediaProvider.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation
import Alamofire
import Unbox
import IDZSwiftCommonCrypto

struct AtresmediaURL {
    static let createSession = "https://servicios.atresplayer.com/j_spring_security_check"
    static let highlights = "http://servicios.atresplayer.com/api/v3/highlights"
    static let urlVideo = "https://servicios.atresplayer.com/api/video/v3/urlVideo/%@/ios_phone/wifi/"
    static let time = "https://servicios.atresplayer.com/api/admin/time"
}

//TODO: Error handling
//TODO: Remove force unwrap hash

struct AtresmediaRequests {

    static func createSession(username: String, password: String, completion: @escaping (Void) -> Void) {
        let parameters = ["j_username": username, "j_password": password]
        Alamofire.request(AtresmediaURL.createSession, method: .post, parameters: parameters).responseString { response in
            if response.result.isSuccess {
                completion()
            }
        }
    }

    static func highlights(completion: @escaping (AtresmediaAPI.Highlights) -> Void) {
        Alamofire.request(AtresmediaURL.highlights).responseJSON { response in

            if let JSON = response.result.value as? UnboxableDictionary {
                let highlights: AtresmediaAPI.Highlights = try! unbox(dictionary: JSON)
                completion(highlights)
            }
        }
    }

    static func videoURL(contentPk: String, completion: @escaping (AtresmediaAPI.VideoURL) -> Void) {
        createtoken(contentPk: contentPk) { token in
            let safeToken = token.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let url = String(format: AtresmediaURL.urlVideo, contentPk).appending(safeToken!)
            Alamofire.request(url).responseJSON { response in

                if let JSON = response.result.value as? UnboxableDictionary {
                    let videoURL: AtresmediaAPI.VideoURL = try! unbox(dictionary: JSON)
                    completion(videoURL)
                }
            }
        }
    }

    private static func createtoken(contentPk: String, completion: @escaping (String) -> Void) {
        time { result in
            let time = String(result + 30)
            let data = contentPk.appending(time)
            let key = "b2zN:Pzf:>WTiC=j$;_e!D.L"
            let hash = HMAC(algorithm: .md5, key: key).update(string: data)!.final()
            completion("\(contentPk)|\(time)|\(hexString(fromArray: hash))")
        }
    }

    private static func time(completion: @escaping (Int) -> Void) {
        Alamofire.request(AtresmediaURL.time).responseString { response in
            if let value = response.result.value, let time = Int(value)  {
                completion(time/1000)
            }
        }
    }

}
