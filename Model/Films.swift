import Foundation


struct MovieModel: Codable {
    let results: [MovieResultModel]

    enum CodingKeys: String, CodingKey {
        case results
        
    }
}


struct MovieResultModel: Codable {
 
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
       
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case id = "id"
    }
}











struct LibraryModel : Codable{
    let results : [LibraryResultModel]
    
    enum CodingKeys: String , CodingKey {
        case results
    }
}


struct LibraryResultModel : Codable {
    let title : String
    let imageURL : String
    let index : Int
    
    enum CodingKeys : String, CodingKey{
        case title = "original_title"
        case imageURL  = "poster_path"
        case index = "index"
    }
}


struct CoreDataModel {
    let title : String
    let url : String
    let detail : String
    let movieId : String
    let id : String
    
    enum Codingkeys : String  {
        case title = "movieTitle"
        case url = "posterURL"
        case detail = "movieDetail"
        case movieId = "movieID"
        case id = "id"
    }
   
    
}
