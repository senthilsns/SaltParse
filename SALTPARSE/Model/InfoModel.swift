//
//  InfoModel.swift
//  SALTPARSE
//
//  Created by SALTSIDE on 13/11/18.
//  Copyright © 2018 SALTSIDE. All rights reserved.
//

import UIKit

class InfoModel: Codable {
    
    var title : String?
    var description : String?
    var image : String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case image
    }
}

