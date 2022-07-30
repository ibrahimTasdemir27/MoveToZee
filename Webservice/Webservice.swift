//
//  Webservice.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import Foundation

class Webservices {
    
    func getFilms(url : URL , completion : @escaping((Movie)?) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error{
                //Hata var ise
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                //Veri var
                
                let decodedData  = try? JSONDecoder().decode(Movie.self, from: data)
                if let decodedData = decodedData {
                    completion(decodedData)
                    
                }
            }
            
        }.resume()
        
        
    }
    
        
    
    
}
