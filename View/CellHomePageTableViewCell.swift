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

    @IBOutlet weak var favoriteButtonDesign: UIButton!
    @IBOutlet weak var filmPosterHome: UIImageView!
    @IBOutlet weak var titlePosterHome: UILabel!
    @IBOutlet weak var detailPosterHome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    @IBAction func favoriteButton(_ index: Int) {
        var favButtonColor = favoriteButtonDesign.tintColor!
        
        switch favButtonColor {
        case UIColor.systemRed :
            favoriteButtonDesign.tintColor = .systemGray
        case UIColor.systemGray :
            favoriteButtonDesign.tintColor = .systemRed
        default:break
        }
        
        //CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let movieCoreModel = NSEntityDescription.insertNewObject(forEntityName: "MovieDatabase", into: context)
        let imageToBinary = filmPosterHome.image?.jpegData(compressionQuality: 0.5)
        
        movieCoreModel.setValue(titlePosterHome.text, forKey: "titleMovie")
        movieCoreModel.setValue(detailPosterHome.text, forKey: "detailMovie")
        movieCoreModel.setValue(imageToBinary, forKey: "imageMovie")
        movieCoreModel.setValue(UUID(), forKey: "id")
        do{
            try context.save()
            print("kayıt edildi")
        }catch{
            print("hata var")
        }
       //
        
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
    
    /*
     Favori butonuna tıklanacak +
     Favori butonunun rengi değişecek +
     Favori butonuna tıklandığı CoreDataya bildirilecek ve kaydedilecek +
     Favoriye alınan film favori sekmesinde sırasıyla gösterilecek
     Favoriden kaldırılabilecek
     
     Core data attirubutes
     Film adı + Film Detayları + Film resmi
     */

    
    
}
