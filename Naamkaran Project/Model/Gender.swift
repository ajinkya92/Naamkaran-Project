//
//  Gender.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 08/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

struct Gender {
    
    var genderName: String
    var image: String
    var genderId: Int
    
    init(genderName: String, genderImage: String, genderId: Int) {
        
        self.genderName = genderName
        self.image = genderImage
        self.genderId = genderId
    }
    
}
