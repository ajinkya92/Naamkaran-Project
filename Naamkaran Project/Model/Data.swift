//
//  Data.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 08/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

typealias Data = [DataElement]

struct DataElement: Codable {
    let id, categoryId, name, meaning: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case name, meaning, gender
    }
}
