//
//  DetailsViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 1.08.2022.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailSegueLabel: UILabel!
    @IBOutlet weak var detailSegueImage: UIImageView!
    var jpeg = ""
    
    
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    var getIndex = 0
    private var model : FilmsTableViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        Webservice().getMovies { movie,  _ in
            if let movie = movie {
                self.model = FilmsTableViewModel(newList: movie)
                self.detailSegueLabel.text = self.model.newList[self.getIndex].overview
                let processor = DownsamplingImageProcessor(size: self.detailSegueImage.bounds.size)
                self.jpeg = self.model.newList[self.getIndex].posterPath!
               
                self.detailSegueImage.kf.setImage(with: URL(string: self.baseUrl + self.jpeg) , placeholder: .none , options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0)), .cacheOriginalImage] , completionHandler: .none )
            }
        }
        detailSegueImage.contentMode = .scaleToFill
    }

}


//self.filmPosterHome.kf.setImage(with: URL(string: baseUrl + movie.posterPath!), placeholder: .none, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0)), .cacheOriginalImage], completionHandler: .none)
