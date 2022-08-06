//
//  NewsTableViewModel.swift
//  MoveToZee
//
//  Created by haliliboswift on 30.07.2022.
//

import Foundation


struct FilmsTableViewModel {
    
    let newList : [MovieResultModel]
    func numberOfRowsInsection() -> Int {
        return self.newList.count
    }
    func newsAtIndexPath(_ index : Int) -> FilmsViewModel {
        let films = self.newList[index]
        return FilmsViewModel(films: films)
    }
}

struct FilmsViewModel {
    let films : MovieResultModel
    
    var originalTitle : String {
        return self.films.originalTitle
    }
    var overview : String {
        return self.films.overview
    }
    var posterPath : String {
        return (self.films.posterPath)!
    }
    
    
}
