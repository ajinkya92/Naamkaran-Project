//
//  GenderCell.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 07/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class GenderCell: UICollectionViewCell {
    
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    
    func configureCell(gender: Gender) {
        
        self.genderImage.image = UIImage(named: gender.image)
        self.genderLabel.text = gender.genderName
    }
    
}
