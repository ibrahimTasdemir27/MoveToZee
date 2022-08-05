//
//  FavoriteViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import CoreData
import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {
    
    var titleArray = [String]()
    var detailArray = [String]()
    var imageurlArray = [String]()
    var idArray = [UUID]()
    var movieidArray = [Int]()
   
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        getFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorite()
        self.tableView.reloadData()
    }
 
    
    func getFavorite() {
        titleArray.removeAll()
        detailArray.removeAll()
        imageurlArray.removeAll()
        idArray.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewMovieDatabase")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let title = result.value(forKey: "movieTitle") as? String {
                    titleArray.append(title)
                }
                if let detail = result.value(forKey: "movieDetail") as? String {
                    detailArray.append(detail)
                }
                if let url = result.value(forKey: "posterURL") as? String {
                    imageurlArray.append(url)
                }
                if let idMv = result.value(forKey: "id") as? UUID {
                    idArray.append(idMv)
                }else{
                    print("no uuid found")
                    
                }
                if let idMovie = result.value(forKey: "movieID") as? Int {
                    movieidArray.append(idMovie)
                }
            }

        } catch {
            print("Error")
        }
    }

    func delFavorite(index : Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let uuidString = idArray[index].uuidString
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewMovieDatabase")
        fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? UUID {
                        if id == idArray[index] {
                            context.delete(result)
                            self.tableView.reloadData()
                            do{
                                try context.save()
                            }catch{
                                print("Silinemedi")
                            }
                        }
                    }
                }
            } catch {
                print("Hata")
            }
    }
}


extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteTableViewCell
        cell.favoriteTitleLabel.text = titleArray[indexPath.row]
        cell.favoriteDetailLabel.text = detailArray[indexPath.row]
        
        var processor = DownsamplingImageProcessor(size: cell.favoriteImageView.bounds.size)
        let fullUrl = "https://image.tmdb.org/t/p/original" + imageurlArray[indexPath.row]
        cell.favoriteImageView.kf.setImage(with: URL(string: fullUrl) , placeholder: .none , options: [.processor(processor) , .scaleFactor(UIScreen.main.scale) , .transition(.fade(0)) , .cacheOriginalImage] ,completionHandler: .none)
        cell.favoriteImageView.layer.cornerRadius = 10
        cell.favoriteImageView.contentMode = .scaleToFill
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            delFavorite(index: indexPath.row)
            movieidArray.remove(at: indexPath.row)
            imageurlArray.remove(at: indexPath.row)
            titleArray.remove(at: indexPath.row)
            detailArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Swipe left to remove from Favorites"
    }
}



