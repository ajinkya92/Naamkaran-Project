//
//  GenderVC.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 08/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class GenderVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let genderArray = [Gender(genderName: "Male", genderImage: "boy", genderId: 1),
    Gender(genderName: "Female", genderImage: "girl", genderId: 2)]
    
    var categoryId = String()
    var genderId = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenderCell", for: indexPath) as? GenderCell else {return UICollectionViewCell()}
        
        cell.configureCell(gender: genderArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = (collectionView.bounds.height/2) - 40
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        genderId = genderArray[indexPath.row].genderId
        
//        print(genderId)
//        print(categoryId)
        
        guard let Datavc = storyboard?.instantiateViewController(withIdentifier: "DataVC") as? DataVC else {return}
        
        Datavc.categoryId = self.categoryId
        Datavc.genderId = self.genderId
        
        self.navigationController?.pushViewController(Datavc, animated: true)
        
    }
    
    

}
