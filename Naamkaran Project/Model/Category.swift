//
//  Category.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 07/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

typealias Category = [CategoryElement]

struct CategoryElement: Codable {
    
    let id: String
    let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "cat_name"
    }
}
