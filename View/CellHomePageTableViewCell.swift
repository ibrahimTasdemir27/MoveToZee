//
//  CellHomePageTableViewCell.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import UIKit
import Kingfisher
import SwiftUI

class CellHomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButtonDesign: UIButton!
    @IBOutlet weak var filmPosterHome: UIImageView!
    @IBOutlet weak var titlePosterHome: UILabel!
    @IBOutlet weak var detailPosterHome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
  
    }
    @IBAction func favoriteButton(_ sender: Any) {
        favoriteButtonDesign.layer.cornerRadius = 230
        favoriteButtonDesign.tintColor = .white
        
    }
   

    func setImage(movie: MovieResultModel) {
        self.titlePosterHome.textColor = .white
        self.titlePosterHome.backgroundColor = .black
        
        self.detailPosterHome.textColor = .white
        self.detailPosterHome.backgroundColor = .black
        
        self.filmPosterHome.layer.borderWidth = 1
        self.filmPosterHome.layer.borderColor = UIColor.white.cgColor
        
        self.titlePosterHome.text = movie.originalTitle
        self.detailPosterHome.text = movie.overview
        
        
        let processor = DownsamplingImageProcessor(size: self.filmPosterHome.bounds.size)

        let baseUrl = "https://image.tmdb.org/t/p/w500"
        

        self.filmPosterHome.kf.setImage(with: URL(string: baseUrl + movie.posterPath!), placeholder: .none, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0)), .cacheOriginalImage], completionHandler: .none)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
