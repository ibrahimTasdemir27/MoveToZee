//
//  CellHomePageTableViewCell.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import UIKit
import Kingfisher
import SwiftUI
import CoreData

class CellHomePageTableViewCell: UITableViewCell {
    
    let starButton = UIButton()
    var idMovieArray = [Int]()
    static var selectedMovie: MovieResultModel?
    private var filmsTableViewModel = FilmsTableViewModel.self
    
    @IBOutlet weak var starButtonDesign: UIButton!
    @IBOutlet weak var favoriteButtonDesign: UIButton!
    @IBOutlet weak var filmPosterHome: UIImageView!
    @IBOutlet weak var titlePosterHome: UILabel!
    @IBOutlet weak var detailPosterHome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        //FireStoreManager().saveLibrary(title: "Deneme 1")
        //FireStoreManager().getLibrary()
        
        
        
        //Layout
        favoriteButtonDesign.frame = CGRect(x: 350 , y: 125, width: 40, height: 40)
        titlePosterHome.frame = CGRect(x: 131, y: 11, width: 215, height: 34)
        detailPosterHome.frame = CGRect(x: 131, y: 45, width: 215, height: 99)
        favoriteButtonDesign.tintColor = .darkGray
        
        starButtonDesign.tintColor = .darkGray
        //starButtonDesign.layer.borderWidth = 1.3
        //starButtonDesign.layer.borderColor = UIColor.black.cgColor
        //starButtonDesign.layer.cornerRadius = 22
        starButtonDesign.frame = CGRect(x: 349, y: 23, width: 40, height: 40)
    }


    func setImage(movie: MovieResultModel) {
        self.titlePosterHome.text = movie.originalTitle
        self.detailPosterHome.text = movie.overview
        
        filmPosterHome.contentMode = .scaleToFill
        filmPosterHome.layer.cornerRadius = 10
    
        
        
        let processor = DownsamplingImageProcessor(size: self.filmPosterHome.bounds.size)

        let baseUrl = "https://image.tmdb.org/t/p/w500"
        

        self.filmPosterHome.kf.setImage(with: URL(string: baseUrl + movie.posterPath!), placeholder: .none, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0)), .cacheOriginalImage], completionHandler: .none)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    /*
     Favori butonuna tıklanacak +
     Favori butonunun rengi değişecek +
     Favori butonuna tıklandığı CoreDataya bildirilecek ve kaydedilecek +
     Favoriye alınan film favori sekmesinde sırasıyla gösterilecek
     Favoriden kaldırılabilecek
     
     Core data attirubutes
     Film adı + Film Detayları + Film resmi
     */

    
    


