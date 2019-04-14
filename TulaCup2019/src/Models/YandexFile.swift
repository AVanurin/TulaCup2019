//
//  YandexFile.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 10/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation


struct YandexFile {
    var media_type: String
    var name: String
    var path: String
    
    var type: String
    
    init(media_type: String, name: String, path: String, type: String) {
        self.media_type = media_type
        self.name = name
        self.path = path
        self.type = type
    }
    
    static func array(json: Any) -> [YandexFile]? {
        guard let dict = json as? NSDictionary else {
            return nil
        }
        
        guard let items = dict["items"] as? NSArray else {
            return nil
        }
        
        var yandexFiles = [YandexFile]()
        
        for item in items {
            guard let itemJSON = item as? NSDictionary else {
                continue
            }
            
            guard let media_type = itemJSON["media_type"] as? String,
                let name = itemJSON["name"] as? String,
                let path = itemJSON["path"] as? String,
                let type = itemJSON["type"] as? String else {
                    continue
            }
            
            yandexFiles.append(YandexFile(media_type: media_type, name: name, path: path, type: type))
            
        }
        return yandexFiles
    }
}
