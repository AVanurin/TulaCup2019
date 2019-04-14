//
//  ContentLoader.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 10/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation
import Alamofire


fileprivate let base_url = "https://cloud-api.yandex.net/v1/"


class ContentLoader {
    class func makeUniveraslHeaders() -> [String:String] {
        return [
            "Accept": "application/json",
            "Authorization": "OAuth \(AppSettings.oath!.accessToken)"
        ]
    }
    
    class func loadImage(path: String, completion: @escaping ()->Void) {
        //let urlString = "\(base_url)disk/resources/download?path=\(path)"
    }
    class func test() {
        let urlString = "\(base_url)disk"
        
        let headers = [
        "Accept": "application/json",
        "Authorization": "OAuth \(AppSettings.oath!.accessToken)"
        ]
        
        Alamofire.request(urlString, headers: headers)
            .responseJSON { response in
                print(response)
        }
    }
    
    // Создание папки на устройстве
    class func makeAppFolder() {
        let urlString = "\(base_url)disk/resources?path=/TulaCup2019Data"
        
        Alamofire.request(urlString, method: .put, headers: makeUniveraslHeaders()).responseJSON { response in
            print(response)
        }
    }
    
    class func files(completion: @escaping([YandexFile])->Void) {
        let urlString = "\(base_url)disk/resources/files"
        
        Alamofire.request(urlString, headers: makeUniveraslHeaders()).responseJSON { response in
            switch response.result {
            case .success(let value):
                //print(value)
                let files = YandexFile.array(json: value)
                
                if files != nil {
                    completion((files?.filter {$0.path.contains("TulaCup2019Data") && $0.media_type == "image"})!)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    class func file(path: String, completion: @escaping(String)->Void) {
        let urlString = "\(base_url)disk/resources/download?path=\(path)"
        
        Alamofire.request(urlString, headers: makeUniveraslHeaders()).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = value as? NSDictionary else {
                    return
                }
                guard let href = json["href"] as? String else {
                    return
                }
                completion(href)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
