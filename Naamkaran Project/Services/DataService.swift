//
//  DataService.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 08/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    
    func getNamesData(url: String, completion: @escaping(_ success: Bool, Data?) -> ()) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
                completion(false, nil)
                return
            } else {
                
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let namesJson = try decoder.decode(Data.self, from: data)
                    completion(true, namesJson)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
                
            }
            
            
        }.resume()
        
        
        
    }
    
}
