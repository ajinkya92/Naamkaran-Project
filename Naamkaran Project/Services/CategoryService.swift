//
//  CategoryService.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 07/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

class CategoryService {
    
    static let instance = CategoryService()
    
    
    func getCategories(url: String, completion: @escaping (_ success: Bool, Category?) -> ()) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(false, nil)
                debugPrint(error?.localizedDescription ?? "")
            } else {
                
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let categoryJson = try decoder.decode(Category.self, from: data)
                    completion(true, categoryJson)
                    return
                }catch{
                    completion(false, nil)
                    debugPrint(error.localizedDescription)
                    return
                }
                
                
            }
            
        }.resume()
        
    }
    
}
