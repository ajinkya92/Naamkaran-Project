//
//  DataCell.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 08/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

protocol DataCellDelegate {
    
    func getIndexPathForRow(indexpath: IndexPath, favButton: UIButton)
    
}

class DataCell: UITableViewCell {
    
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var meaningLbl: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var delegate: DataCellDelegate?
    var index: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        favButton.setImage(UIImage(named: "defaultstar"), for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(data: DataElement) {
        
        self.nameLbl.text = data.name
        self.meaningLbl.text = data.meaning
        
        
    }
    
    @IBAction func favouriteBtnTapped(_ sender: UIButton) {
        
        delegate?.getIndexPathForRow(indexpath: index, favButton: favButton)
        
        print(index)
        
    }
    
    

}
