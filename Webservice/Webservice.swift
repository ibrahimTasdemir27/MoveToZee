//
//  Webservice.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import Alamofire
import Foundation

class Webservice{
    
    
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=50bbd6f582cd05dd01b18c5309bc9ae5"
    var pageNumber = 1

    func getMovies( completion: @escaping ([MovieResultModel]?, String?)-> Void){

        let request = AF.request(url)
        
        request.validate().responseDecodable(of: MovieModel.self) { response in
            switch response.result{
            case .success(let movieInfo):
                completion(movieInfo.results, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}


