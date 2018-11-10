//
//  ViewController.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 07/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    var categoryArray = Category()
    var categoryImagesArray = ["hindu", "trending", "muslim", "christain"]
    var categotyId = String()
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getCategoryData()
        
    }
    
}

// MARK: This is function to get data from Category Service

extension CategoryVC {
    
    func getCategoryData() {
        
        CategoryService.instance.getCategories(url: CATEGORY_LIST_URL) { (true, returnedCategoryData) in
            
            if let returnedCategoryData = returnedCategoryData {
                
                self.categoryArray = returnedCategoryData
                
               // print(self.categoryArray)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
    }
    
}

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {return UICollectionViewCell()}
        
        cell.categoryImage.image = UIImage(named: categoryImagesArray[indexPath.row])
        
        cell.categoryName.text = categoryArray[indexPath.row].categoryName
        
        categotyId = categoryArray[indexPath.row].id
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        categotyId = categoryArray[indexPath.row].id
        
        guard let genderVC = storyboard?.instantiateViewController(withIdentifier: "GenderVC") as? GenderVC else {return}
        
        genderVC.categoryId = categotyId
        
        self.navigationController?.pushViewController(genderVC, animated: true)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width/2.0) - 20
        let height = width + 20
        
        return CGSize(width: width, height: height)
    }
    
    
}

