//
//  DetailsViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 1.08.2022.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import CoreData
import FirebaseAuth

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailSegueLabel: UILabel!
    @IBOutlet weak var detailSegueImage: UIImageView!

    
    let firestoreDatabase = Firestore.firestore()
    var messageDict : [Messages] = []
    var libraryDict : [LibraryResultModel] = []
    var jpeg = ""
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    var getIndex = 0
    var segue = 0
    private var model : FilmsTableViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if segue == 1 {
            //HomePage
            Webservice().getMovies { movie,  _ in
                if let movie = movie {
                    self.model = FilmsTableViewModel(newList: movie)
                    self.detailSegueLabel.text = self.model.newList[self.getIndex].overview
                    let fullUrl = self.baseUrl + self.model.newList[self.getIndex].posterPath!
                    self.setImage(url: fullUrl)
                }
            }
            
        }
        
        if segue == 3 {
            getFavorite(moviesID: getIndex)
        }
        detailSegueImage.contentMode = .scaleToFill
    }
    
    func getFavorite(moviesID : Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewMovieDatabase")
        fetchRequest.predicate = NSPredicate(format: "movieID = %d ", moviesID)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let resutls = try context.fetch(fetchRequest)
            
            for result in resutls as! [NSManagedObject] {
                
                if let id = result.value(forKey: "movieID") as? Int {
                    if id == moviesID {
                        if let detail = result.value(forKey: "movieDetail") as? String {
                            detailSegueLabel.text = detail
                        }
                        if let url = result.value(forKey: "posterURL") as? String {
                            let fullUrl = baseUrl + url
                            setImage(url: fullUrl)
                        }
                    }
                }
            }
        }catch{
            print("hata var")
        }
        
        
    }
    
    
    func setImage(url : String){
        let processor = DownsamplingImageProcessor(size: self.detailSegueImage.bounds.size)
        detailSegueImage.kf.setImage(with: URL(string: url), placeholder: .none, options: [.processor(processor) , .scaleFactor(UIScreen.main.scale),.transition(.fade(1))], completionHandler: .none)
    }
    
    @IBAction func commentOn(_ sender: Any) {
        //commentLabel.text -> Kaydedilecek
        let comment = commentLabel.text
        let user = Auth.auth().currentUser?.email

        if comment != nil && user != nil {
            if comment != "" && user != "" {
                FireStorageManager().saveMessage(comment: comment!, user: user!)
            }
        }
    }
    
}




extension DetailsViewController{
    //Firebase veri kaydetme
    
    //Kullanıcı yorum yaptı
    //Yorumu gösterme
    
    
    
    
    
    
    
}
